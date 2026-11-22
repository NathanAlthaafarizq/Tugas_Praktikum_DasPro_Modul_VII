Program Soal3;                                  
uses crt;

type
    matkul = record                             // tipe data untuk 1 mata kuliah
        nama_matkul  : string[25];              
        jumlah_sks   : integer;                 
        nilai        : string[2];               
        skor         : double;                  
    end;

    mahasiswa = record                          // tipe data untuk 1 mahasiswa
        nama          : string[25];             
        NIM           : string[25];             
        jumlah_matkul : integer;                
        list_matkul   : array[1..8] of matkul;  

    end;

Procedure Garis;                                // mencetak garis pemisah
var
    k : integer;                                
begin
    for k := 1 to 55 do                         
    write('=');                                 
    writeln;                                   
end;

Function Kapital(s : string): string;           // mengubah teks jadi huruf besar
var
    k : integer;                                

begin
    for k := 1 to length(s) do                  // dari huruf pertama sampai terakhir
        s[k] := upcase(s[k]);                   // ubah tiap huruf jadi kapital
    kapital := s;                               // kembalikan hasilnya
end;

Function NilaiHuruf(h : string): double;        // mengubah nilai huruf jadi angka bobot
begin
    if      h = 'A'   then NilaiHuruf := 4      // A = 4
    else if h = 'B+'  then NilaiHuruf := 3.5    // B+ = 3.5
    else if h = 'B'   then NilaiHuruf := 3      // B = 3
    else if h = 'C+'  then NilaiHuruf := 2.5    // C+ = 2.5
    else if h = 'C'   then NilaiHuruf := 2      // C = 2
    else if h = 'D'   then NilaiHuruf := 1      // D = 1
    else if h = 'E'   then NilaiHuruf := 0      // E = 0
    else                   NilaiHuruf := -1     // selain itu = -1 (tidak valid)
end;

Procedure BiodataMahasiswa(var m : mahasiswa; nomor : integer);  // input data 1 mahasiswa
var
    k : integer;                                
begin
    clrscr;                                     
    writeln('Masukan Data Mahasiswa ke - ', nomor, ' : ');  // judul input
    write('Nama : '); readln(m.nama);           // input nama
    write('NIM  : '); readln(m.NIM);            // input NIM
    repeat                                      // ulangi sampai jumlah valid
        write('Jumlah Mata Kuliah : '); readln(m.jumlah_matkul);  // input jumlah matkul
        if (m.jumlah_matkul < 1) or (m.jumlah_matkul > 8) then    // jika di luar 1-8
            writeln('Jumlah tidak valid, coba lagi');             
    until (m.jumlah_matkul >= 1) and (m.jumlah_matkul <= 8);      // berhenti jika 1-8


    for k := 1 to m.jumlah_matkul do            // input tiap mata kuliah
    with m.list_matkul[k] do                    // langsung akses isi matkul ke-k
    begin
        clrscr;                                 
        writeln(' --- Data Mahasiswa ke - ', nomor, ' --- ');  
        writeln('Mata Kuliah ke    - ', k);     
        write('Nama Mata Kuliah  : '); readln(nama_matkul);    // input nama matkul
        write('Jumlah SKS        : '); readln(jumlah_sks);     // input SKS
        repeat                                  // ulangi sampai nilai valid
            write('Nilai Mata Kuliah : '); readln(nilai);      // input nilai huruf
            nilai := Kapital(nilai);            // ubah ke huruf besar 
            if NilaiHuruf(nilai) = -1 then      // jika nilai tidak dikenal
                writeln('Nilai tidak valid (A, B+, B, C+, C, D, E)');  
        until NilaiHuruf(nilai) <> -1;          // berhenti jika nilai valid
        skor := jumlah_sks * NilaiHuruf(nilai); // hitung skor = SKS x bobot
    end;
end;

Procedure Spasi(n : integer);                   // mencetak spasi sebanyak n
var
    k : integer;                                
begin
    for k := 1 to n do write(' ');              
end;

Procedure TampilData(m : mahasiswa);            // menampilkan data 1 mahasiswa
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
    for k := 1 to m.jumlah_matkul do            // tampilkan tiap mata kuliah
    with m.list_matkul[k] do                    // akses isi matkul ke-k
    begin
        write('| ', k:2, ' | ', nama_matkul);   // cetak nomor dan nama matkul
        Spasi(25 - length(nama_matkul));        
        write(' | ', jumlah_sks:3, ' | ', nilai);  // cetak SKS dan nilai
        Spasi(5 - length(nilai));               
        writeln(' | ', skor:0:1);               // cetak skor (1 angka desimal)
        total_sks  := total_sks + jumlah_sks;   // tambahkan ke total SKS
        total_skor := total_skor + skor;        // tambahkan ke total skor
    end;
    Garis;                                      
    writeln('TOTAL SKOR : ', total_skor:0:1);   // tampilkan total skor
    Garis;                                      
    writeln('Jumlah SKS : ', total_sks);        // tampilkan total SKS
    if total_sks > 0 then                       // cek agar tidak dibagi nol
        ip := total_skor / total_sks            // IP = total skor / total SKS
    else
        ip := 0;                                
    writeln('IP         : ', ip:0:2);           // tampilkan IP (2 angka desimal)
    writeln;                                    
end;

var
    i  : integer;                               // i = penghitung mahasiswa
    jumlah_mhs : integer;                       // banyak mahasiswa yang diinput
    total_mahasiswa : array[1..50] of mahasiswa;  // menyimpan data semua mahasiswa (maks 50)

begin
    clrscr;                                    
    repeat                                      
    write('Jumlah Mahasiswa: ');                
    readln(jumlah_mhs);                         // input jumlah mahasiswa
    if (jumlah_mhs < 1) or (jumlah_mhs > 50) then   
        writeln('Total mahasiswa tidak valid, coba lagi');  
    until (jumlah_mhs >= 1) and (jumlah_mhs <= 50); 

    for i := 1 to jumlah_mhs do                 // proses tiap mahasiswa
    begin
        BiodataMahasiswa(total_mahasiswa[i], i);    // input data mahasiswa ke-i
        TampilData(total_mahasiswa[i]);         // tampilkan data mahasiswa ke-i
        if i < jumlah_mhs then                  // jika masih ada mahasiswa berikutnya
        begin
            writeln('Tekan sembarang tombol untuk melihat data selanjutnya..');  
            readln;                             
        end;
    end;
    readln;                                     
end.