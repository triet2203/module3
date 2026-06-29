use furama;

-- 2. Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
select * from nhan_vien
where (
 ho_ten like 'H%'
 or ho_ten like 'T%' 
 or ho_ten like 'K%'
)
and char_length(ho_ten) <= 15;

-- 3. Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
select * from khach_hang
where timestampdiff(year, ngay_sinh, curdate()) between 18 and 50
and (
 dia_chi like '% Đà Nẵng'
 or dia_chi like '% Quảng Trị'
 );
 
 -- 4. Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
select k.ma_khach_hang, k.ho_ten, lk.ten_loai_khach, count(h.ma_khach_hang) as so_lan_dat_phong from khach_hang k
inner join loai_khach lk
	on k.ma_loai_khach = lk.ma_loai_khach
inner join hop_dong h
	on k.ma_khach_hang = h.ma_khach_hang
where lk.ten_loai_khach = 'Diamond'
group by k.ma_khach_hang, k.ho_ten, lk.ten_loai_khach
order by so_lan_dat_phong;
     
-- 5. Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien
-- (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet)
-- cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
select 
	k.ma_khach_hang, 
    k.ho_ten, 
    lk.ten_loai_khach, 
    hd.ma_hop_dong, 
    dv.ten_dich_vu, 
    hd.ngay_lam_hop_dong, 
    hd.ngay_ket_thuc,
    ifnull(dv.chi_phi_thue, 0) 
    + ifnull(sum(hdct.so_luong * dvdk.gia), 0) as tong_tien
from khach_hang k
left join loai_khach lk
	on k.ma_loai_khach = lk.ma_loai_khach
left join hop_dong hd
	on k.ma_khach_hang = hd.ma_khach_hang
left join dich_vu dv
	on hd.ma_dich_vu = dv.ma_dich_vu
left join hop_dong_chi_tiet hdct
	on hd.ma_hop_dong = hdct.ma_hop_dong
left join dich_vu_di_kem dvdk
	on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
group by k.ma_khach_hang, k.ho_ten, lk.ten_loai_khach, hd.ma_hop_dong, dv.ten_dich_vu, hd.ngay_lam_hop_dong, hd.ngay_ket_thuc, dv.chi_phi_thue
order by k.ma_khach_hang;