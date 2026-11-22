Program Soal3;
uses crt;


type
    matkul = record
        nama_matkul  : string[25];
        jumlah_sks   : integer;
        nilai        : string[2];
        skor         : double;
    end;

    mahasiswa = record
        nama          : string[25];
        NIM           : string[25];
        jumlah_matkul : integer;
        list_matkul   : array[1..8] of matkul;

    end;

Procedure Garis;
var
    k : integer;
begin
    for k := 1 to 55 do 
    write('=');
    writeln;
end;

Function Kapital(s : string): string;
var
    k : integer;
begin
    for k := 1 to length(s) do
        s[k] := upcase(s[k]);
    kapital := s;
end;

Function NilaiHuruf(h : string): double;
begin
    if      h = 'A'   then NilaiHuruf := 4
    else if h = 'B+'  then NilaiHuruf := 3.5
    else if h = 'B'   then NilaiHuruf := 3
    else if h = 'C+'  then NilaiHuruf := 2.5
    else if h = 'C'   then NilaiHuruf := 2
    else if h = 'D'   then NilaiHuruf := 1
    else if h = 'E'   then NilaiHuruf := 0
    else                   NilaiHuruf := -1
end;

Procedure BiodataMahasiswa(var m : mahasiswa; nomor : integer);
var
    k : integer;
begin
    clrscr;
    writeln('Masukan Data Mahasiswa ke - ', nomor, ' : ');
    write('Nama : '); readln(m.nama);
    write('NIM  : '); readln(m.NIM);
    repeat
        write('Jumlah Mata Kuliah : '); readln(m.jumlah_matkul);
        if (m.jumlah_matkul < 1) or (m.jumlah_matkul > 8) then 
            writeln('Jumlah tidak valid, coba lagi');
    until (m.jumlah_matkul >= 1) and (m.jumlah_matkul <= 8);

    for k := 1 to m.jumlah_matkul do 
    with m.list_matkul[k] do
    begin
        clrscr;
        writeln(' --- Data Mahasiswa ke - ', nomor, ' --- ');
        writeln('Mata Kuliah ke    - ', k);
        write('Nama Mata Kuliah  : '); readln(nama_matkul);
        write('Jumlah SKS        : '); readln(jumlah_sks);
        repeat
            write('Nilai Mata Kuliah : '); readln(nilai);
            nilai := Kapital(nilai);
            if NilaiHuruf(nilai) = -1 then
                writeln('Nilai tidak valid (A, B+, B, C+, C, D, E)');
        until NilaiHuruf(nilai) <> -1;
        skor := jumlah_sks * NilaiHuruf(nilai);
    end;
end;

Procedure Spasi(n : integer);
var
    k : integer;
begin
    for k := 1 to n do write(' ');
end;

Procedure TampilData(m : mahasiswa);
var
    k, total_sks : integer;
    total_skor, ip : double;
begin
    clrscr;
    total_sks  := 0;
    total_skor := 0;
    writeln('Nama : ', m.nama);
    writeln('NIM  : ', m.NIM);
    Garis;
    writeln('| No | Mata Kuliah              | SKS | Nilai | Skor');
    Garis;
    for k := 1 to m.jumlah_matkul do
    with m.list_matkul[k] do
    begin
        write('| ', k:2, ' | ', nama_matkul);
        Spasi(25 - length(nama_matkul));
        write(' | ', jumlah_sks:3, ' | ', nilai);
        Spasi(5 - length(nilai));
        writeln(' | ', skor:0:1);
        total_sks  := total_sks + jumlah_sks;
        total_skor := total_skor + skor;
    end;
    Garis;
    writeln('TOTAL SKOR : ', total_skor:0:1);
    Garis;
    writeln('Jumlah SKS : ', total_sks);
    if total_sks > 0 then
        ip := total_skor / total_sks
    else
        ip := 0;
    writeln('IP         : ', ip:0:2);
    writeln;
end;

var
    biodata : mahasiswa;
    i , n : integer;
    jumlah_mhs : integer;
    total_mahasiswa : array[1..50] of mahasiswa;

begin
    clrscr;
    repeat
    write('Jumlah Mahasiswa: ');
    readln(jumlah_mhs);
    if (jumlah_mhs < 1) or (jumlah_mhs > 50) then 
        writeln('Total mahasiswa tidak valid, coba lagi');
    until (jumlah_mhs >= 1) and (jumlah_mhs <= 50);

    for i := 1 to jumlah_mhs do
    begin
        BiodataMahasiswa(total_mahasiswa[i], i);
        TampilData(total_mahasiswa[i]);
        if i < jumlah_mhs then
        begin
            writeln('Tekan sembarang tombol untuk melihat data selanjutnya..');
            readln;
        end;
    end;
    readln;
end.
