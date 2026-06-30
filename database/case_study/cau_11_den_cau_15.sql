use furama;

-- 11. Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
select distinct dvdk.ma_dich_vu_di_kem, dvdk.ten_dich_vu_di_kem
from dich_vu_di_kem dvdk
inner join hop_dong_chi_tiet hdct
	on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
inner join hop_dong hd
	on hd.ma_hop_dong = hdct.ma_hop_dong
inner join khach_hang kh
	on hd.ma_khach_hang = kh.ma_khach_hang
inner join loai_khach lk
	on kh.ma_loai_khach = lk.ma_loai_khach
where lk.ten_loai_khach = 'Diamond' and (
	kh.dia_chi like '% Vinh'
    or kh.dia_chi like '% Quảng Ngãi'
);

-- 12. Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), ten_dich_vu, so_luong_dich_vu_di_kem
-- (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.
select hd.ma_hop_dong, nv.ho_ten, kh.ho_ten, kh.so_dien_thoai, dv.ten_dich_vu, ifnull(sum(hdct.so_luong),0) as so_luong_dich_vu_di_kem, hd.tien_dat_coc
from hop_dong hd
join nhan_vien nv
	on hd.ma_nhan_vien = nv.ma_nhan_vien
join khach_hang kh
	on hd.ma_khach_hang = kh.ma_khach_hang
join dich_vu dv
	on hd.ma_dich_vu = dv.ma_dich_vu
left join hop_dong_chi_tiet hdct
	on hd.ma_hop_dong = hdct.ma_hop_dong
where (
month(hd.ngay_lam_hop_dong) between 10 and 12
and year(hd.ngay_lam_hop_dong) = 2020
)
and dv.ma_dich_vu not in (
select h.ma_dich_vu from hop_dong h
where month(h.ngay_lam_hop_dong) between 1 and 6
and year(h.ngay_lam_hop_dong) = 2021
)
group by hd.ma_hop_dong, nv.ho_ten, kh.ho_ten, kh.so_dien_thoai, dv.ten_dich_vu, hd.tien_dat_coc;
