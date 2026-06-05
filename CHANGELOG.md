# Changelog

## 2026-06-06
- ฉลาดขึ้นกับเอกสารยาว: request ที่ context เกิน ~150k ตัวอักษรจะใส่ `repeat_penalty 1.3` + `num_predict 4096` ให้อัตโนมัติ (Ollama) — แก้อาการวน loop ตอน generate และจับคู่ข้อมูลข้าม context ผิดตัว (พิสูจน์ด้วย stress test จริงที่ 190k token: multi-hop 0/2 → 2/2) โดยไม่กระทบ codegen ปกติ

## 2026-06-05
- แก้ ESC ไม่ทำงานบางครั้ง: ตอนนี้หยุดได้ทันทีแม้กำลังรอ token แรก (โหลดโมเดล/prompt eval) และระหว่างรัน tools (ไม่ยิงรอบใหม่ต่อ) — รวมถึงฆ่า bash ที่กำลังรันอยู่ทันที
- ใช้ Ollama ผ่าน LAN ได้: wizard ถาม URL/IP (ใส่แค่ IP ได้) + วิธีเปิด server รับ LAN ใน README
- ระบบแจ้งเตือนอัปเดต + คำสั่ง /update
- เพิ่ม screenshot ใน README
- เผยแพร่ครั้งแรก: agent.py + 42 skills + install.sh
