#include <Arduino.h>
#include <esp_now.h>
#include <WiFi.h>
#define FLEX1 34
#define FLEX2 35
#define FLEX3 32
#define FLEX4 33
#define FLEX5 39
#define RED 22
#define BLU 23
unsigned short int sensors[5]={FLEX1,FLEX2,FLEX3,FLEX4,FLEX5};
// Variables para servos
int servos[5]={0};
//Calibración
void calibrate();
int flex[5][2];
// MAC Address
uint8_t broadcastAddress[] = {0x40, 0x91, 0x51, 0xBD, 0x53, 0xA4};
uint8_t broadcastAddress1[] = {0x30, 0xC6, 0xF7, 0x0B, 0x5E, 0x2C};
//Data structure
typedef struct message{
int a;
int b;
int c;
int d;
int e;
}message;
message Data;
// Peer info
esp_now_peer_info_t peerInfo;
// Función para saber si se recibió la información o no
void OnDataSent(const uint8_t *mac_addr, esp_now_send_status_t status) {
Serial.print("\r\nLast Packet Send Status:\t");
Serial.println(status == ESP_NOW_SEND_SUCCESS ? "Delivery Success" : "Delivery
Fail");
}
void setup() {
for(int i=0;i<5;i++){
pinMode(sensors[i],INPUT);
}
pinMode(RED,OUTPUT);
pinMode(BLU,OUTPUT);
// Serial Monitor
Serial.begin(115200);
// ESP32 como una Wi-Fi Station
WiFi.mode(WIFI_STA);
// Inicializar ESP-NOW
if (esp_now_init() != ESP_OK) {
Serial.println("Error initializing ESP-NOW");
return;
}
// Revisar función de información recibida
esp_now_register_send_cb(OnDataSent);
// Register peer
memcpy(peerInfo.peer_addr, broadcastAddress, 6);
peerInfo.channel = 0;
peerInfo.encrypt = false;
// Add peer
if (esp_now_add_peer(&peerInfo) != ESP_OK){
Serial.println("Failed to add peer");
return;
}
memcpy(peerInfo.peer_addr, broadcastAddress1, 6);
peerInfo.channel = 0;
peerInfo.encrypt = false;
// Emparejamiento
if (esp_now_add_peer(&peerInfo) != ESP_OK){
Serial.println("Failed to add peer");
return;
}
calibrate();
}
void loop() {
int a=map(analogRead(FLEX1),flex[0][0],flex[0][1],5,122);
int b=map(analogRead(FLEX2),flex[1][0],flex[1][1],5,110);
int c=map(analogRead(FLEX3),flex[2][0],flex[2][1],38,175);
int d=map(analogRead(FLEX4),flex[3][0],flex[3][1],175,47);
int e=map(analogRead(FLEX5),flex[4][0],flex[4][1],175,83);
Serial.println(analogRead(FLEX1));
if(a<5) a=5;
if(b<5) b=5;
if(c<38) c=38;
if(d<47) d=47;
if(e<83) e=83;
if(a>122) a=122;
if(b>110) b=110;
if(c>175) c=175;
if(d>175) d=175;
if(e>175) e=175;
Data.a=a;
Data.b=b;
Data.c=c;
Data.d=d;
Data.e=e;
// Enviar estructura vía ESP-NOW
esp_err_t result = esp_now_send(broadcastAddress, (uint8_t *) &Data, sizeof(Data));
if (result == ESP_OK) {
Serial.println("Sending confirmed");
digitalWrite(RED,LOW);
}
else {
Serial.println("Sending error");
digitalWrite(RED,HIGH);
}
//Gráfica
Data.a=analogRead(FLEX1);
Data.b=analogRead(FLEX2);
Data.c=analogRead(FLEX3);
Data.d=analogRead(FLEX4);
Data.e=analogRead(FLEX5);
result = esp_now_send(broadcastAddress1, (uint8_t *) &Data, sizeof(Data));
if (result == ESP_OK) {
Serial.println("Sending confirmed");
digitalWrite(RED,LOW);
}
else {
Serial.println("Sending error");
digitalWrite(RED,HIGH);
}
delay(200);
}
void calibrate(){
//ALTO
//INDICADOR
digitalWrite(RED,HIGH);
digitalWrite(BLU,LOW);
Serial.println("ALTO");
delay(2000);
for (int i=0;i<5;i++){
for (int j=0;j<4999;j++){
flex[i][0]+=analogRead(sensors[i]);
}
}
//BAJO
//INDICADOR
digitalWrite(RED,LOW);
digitalWrite(BLU,HIGH);
Serial.println("BAJO");
delay(2000);
for (int i=0;i<5;i++){
for (int j=0;j<4999;j++){
flex[i][1]+=analogRead(sensors[i]);
}
}
for (int i=0;i<5;i++){
//PROMEDIO
flex[i][0]/=5000;
flex[i][1]/=5000;
}
digitalWrite(RED,LOW);
digitalWrite(BLU,LOW);
}
