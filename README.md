```md
# Expense Tracker App

แอปพลิเคชัน Flutter สำหรับบันทึกรายรับรายจ่าย พร้อมการแสดงข้อมูลผ่าน Dashboard โดยใช้ Firebase Firestore ในการเก็บข้อมูล

## คุณสมบัติ

- **บันทึกรายรับรายจ่าย**: ผู้ใช้สามารถบันทึกข้อมูลรายรับรายจ่าย พร้อมระบุประเภท (รายรับ/รายจ่าย) จำนวนเงิน และรายละเอียดเพิ่มเติม
- **เลือกวันที่**: ผู้ใช้สามารถเลือกวันที่สำหรับการบันทึกข้อมูล
- **Dashboard**: มีหน้า Dashboard สำหรับแสดงข้อมูลรวมของรายรับรายจ่าย พร้อมกราฟแสดงสัดส่วนรายรับรายจ่าย
- **Firebase Firestore**: ใช้ Firebase Firestore ในการเก็บข้อมูลบันทึกรายรับรายจ่ายของผู้ใช้แต่ละคน

## การติดตั้ง

1. Clone โปรเจกต์นี้จาก GitHub:

   ```bash
   git clone https://github.com/username/expense-tracker-app.git
   cd expense-tracker-app
   ```

2. ติดตั้ง dependencies ทั้งหมด:

   ```bash
   flutter pub get
   ```

3. ตั้งค่า Firebase:

   - เพิ่มโปรเจกต์ Firebase ของคุณและดาวน์โหลดไฟล์ `google-services.json` (สำหรับ Android) และ `GoogleService-Info.plist` (สำหรับ iOS)
   - วางไฟล์เหล่านี้ในไดเรกทอรีที่ถูกต้อง (`android/app` สำหรับ Android และ `ios/Runner` สำหรับ iOS)

4. รันโปรเจกต์:

   ```bash
   flutter run
   ```

## การใช้งาน

1. **ลงทะเบียน**: ผู้ใช้สามารถลงทะเบียนด้วยอีเมลและรหัสผ่าน
2. **เข้าสู่ระบบ**: เข้าสู่ระบบด้วยอีเมลและรหัสผ่านที่ลงทะเบียนไว้
3. **บันทึกรายรับรายจ่าย**: กรอกจำนวนเงิน เลือกประเภท รายรับหรือรายจ่าย ระบุวันที่ และเขียนโน้ตเพิ่มเติม
4. **ดูข้อมูลใน Dashboard**: หลังจากบันทึกข้อมูลแล้ว สามารถดูสรุปยอดรวมรายรับ รายจ่าย และยอดคงเหลือในหน้า Dashboard ได้ พร้อมกับการแสดงกราฟวงกลมเพื่อแสดงสัดส่วนรายรับรายจ่าย

## ตัวอย่างหน้าจอ (Screenshots)

| หน้าสมัครสมาชิก          | หน้าเข้าสู่ระบบ          | หน้าบันทึกข้อมูล         | หน้า Dashboard           |
|--------------------------|--------------------------|--------------------------|
| ![image](https://github.com/user-attachments/assets/eeb4b560-6e19-4f98-a066-38a7606b0282) | ![image](https://github.com/user-attachments/assets/672104af-58bc-4654-ae0c-31dd196599fb) | ![image](https://github.com/user-attachments/assets/3d23fc34-597a-4db6-aed7-df5564dea94e) | ![image](https://github.com/user-attachments/assets/06c7bca1-210a-4bb8-87e1-f3a1d7647bfc) |

## เทคโนโลยีที่ใช้

- **Flutter**: สำหรับการพัฒนาแอปพลิเคชัน cross-platform
- **Firebase Authentication**: สำหรับการจัดการผู้ใช้และการเข้าสู่ระบบ
- **Firebase Firestore**: สำหรับการเก็บข้อมูลบันทึกรายรับรายจ่าย
- **Intl Package**: สำหรับการจัดการวันที่และเวลา
- **Syncfusion Flutter Charts**: สำหรับการสร้างกราฟวงกลมในหน้า Dashboard



## การสนับสนุน

หากมีปัญหาหรือข้อสงสัยเกี่ยวกับการติดตั้งหรือการใช้งานแอป สามารถเปิด Issue ใน [GitHub Repository](https://github.com/username/expense-tracker-app/issues)

## ผู้เขียน

- [Your Name](https://github.com/username) - Flutter Developer
```
