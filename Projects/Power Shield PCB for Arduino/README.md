**Arduino Shield with Buck Converter for High-Current LED Driving**

![image](https://github.com/user-attachments/assets/16404e42-d52e-4712-a8e3-6a987adf835a)

This folder contains the **PCB design files** for an **Arduino shield** that allows the Arduino to drive **two LEDs with high current draw**, while also powering the Arduino itself using an integrated **buck converter**. The project was designed using **Altium Designer**, and the buck converter was developed with the help of the **Texas Instruments WeBench Tool**.

## 🌟 **Project Overview**

The goal of this project was to create a **versatile Arduino shield** capable of:  
1. **Powering the Arduino UNO** from a high-voltage source (12V).  
2. Providing a stable **5V output** with a **maximum current of 1A** for powering other components.  
3. Acting as a **current source for two high-current LEDs**, while allowing control via Arduino pins.

![image](https://github.com/user-attachments/assets/d56172e8-c69d-4cb4-9750-ab8f4432f823)

### **Key Features**
- **Buck Converter Design**:  
   - Input Voltage: 12V  
   - Output Voltage: 5V  
   - Maximum Current Draw: 1A  
   - IC Used: **NPI54C3R3MTRF**
   - Designed with **Texas Instruments WeBench Tool** for precision and optimization.  
- **Arduino UNO Rev3 Pin Layout**:  
   - Designed as a shield to integrate seamlessly with the Arduino UNO, using its standard pinout.  
   - Provides direct power to the Arduino while also allowing it to control the LEDs.  
- **High-Current LED Support**:  
   - Supports two LEDs with high current draw.  
   - Ensures stable operation and reliable current sourcing for the LEDs.
 
![image](https://github.com/user-attachments/assets/a94211c8-44c5-4fbf-ad79-0a07fc5dd4ed)


## 🛠️ **Design Process**

1. **Buck Converter Design**:  
   - The buck converter was designed using the **WeBench Tool** from Texas Instruments, ensuring optimal performance for the specified voltage and current requirements.  
   - IC Used: **NPI54C3R3MTRF**, a robust and efficient component for handling high currents.

2. **Arduino Shield Layout**:  
   - Designed in **Altium Designer**, adhering to the Arduino UNO Rev3 pin layout for seamless compatibility.  
   - Includes pinouts for the LEDs, ensuring controlled operation driven by the Arduino.

3. **PCB Fabrication**:  
   - The PCB layout ensures efficient power delivery and minimizes heat dissipation issues.  
   - Compact and modular design for easy integration with existing Arduino projects.

## 🚨 **Important Notes**

- The shield is designed specifically for the **Arduino UNO Rev3** layout but may be compatible with other Arduino boards using the same pinout.  
- Ensure proper handling and connection of high-current LEDs to avoid damage to components.  
- The project does not include the Arduino control code. Users can develop their own sketches to control the LEDs based on their requirements.

## 🔋 **Applications**

This Arduino shield can be used in:  
- **High-Power LED Projects**: Control and drive LEDs requiring large current draw.  
- **Custom Arduino Projects**: Provides a reliable power source for both the Arduino and external components.  
- **Prototyping**: A versatile shield for experimenting with high-current devices and power-efficient designs.
