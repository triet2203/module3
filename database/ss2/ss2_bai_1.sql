create database ss2_bai_tap_1;

use ss2_bai_tap_1;

create table phieu_xuat(
	so_PX int primary key,
    ngay_xuat date
);

create table phieu_nhap(
	so_PN int primary key,
    ngay_nhap date
);

create table vat_tu(
	ma_vat_tu int primary key,
    ten_vat_tu varchar(50)
);

create table nhacc(
	ma_ncc varchar(10) primary key,
    ten_ncc varchar(50),
    dia_chi varchar(50)
);

create table dondh(
	so_dh int primary key,
    ngay_dh date,
    ma_ncc varchar(50),
    foreign key(ma_ncc) references nhacc(ma_ncc)
);

create table ct_phieu_xuat(
	so_PX int,
    ma_vat_tu int,
    primary key (so_PX, ma_vat_tu),
    dg_xuat decimal(12,2),
    sl_xuat int,
    foreign key(so_PX) references phieu_xuat(so_PX),
    foreign key(ma_vat_tu) references vat_tu(ma_vat_tu)
);

create table ct_phieu_nhap(
	so_PN int,
    ma_vat_tu int,
    primary key (so_PN, ma_vat_tu),
    dg_nhap decimal(12,2),
    sl_nhap int,
    foreign key(so_PN) references phieu_nhap(so_PN),
    foreign key(ma_vat_tu) references vat_tu(ma_vat_tu)
);

create table ct_dondh(
	so_dh int,
    ma_vat_tu int,
    primary key(so_dh, ma_vat_tu),
    foreign key(so_dh) references dondh(so_dh),
    foreign key(ma_vat_tu) references vat_tu(ma_vat_tu)
);

create table sdt_nhacc(
	ma_ncc varchar(10),
    sdt varchar(50),
    primary key (ma_ncc, sdt),
    foreign key(ma_ncc) references nhacc(ma_ncc)
);