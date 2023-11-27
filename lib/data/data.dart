import 'package:wonderful_kalsel/model/country_model.dart';

List<CountryModel> getCountries() {
  return [
    CountryModel(
        namaWisata: "Gunung Meratus",
        namaKota: "Kotabaru",
        label: "Teratas",
        deskripsi: "Meratus merupakan kawasan pegunungan yang berada di tenggara Pulau Kalimantan serta membelah Provinsi Kalimantan Selatan menjadi dua. Pegunungan ini membentang sepanjang ± 600 km² dari arah baratdaya-timulaut dan membelok ke arah utara hingga perbatasan provinsi Kalimantan Tengah dan Kalimantan Timur.",
        alamat: "Limbur, Hampang, Kabupaten Kotabaru, Kalimantan Selatan",
        rating: 4.7,
        imgUrl:
            "https://i.pinimg.com/564x/5d/1c/a7/5d1ca70dc0bf425ac0639e401cec74f9.jpg"),
    CountryModel(
        namaWisata: "Pasar Terapung",
        namaKota: "Banjarmasin",
        label: "Populer",
        deskripsi: "pasar tradisional yang berada di atas Sungai Barito, tepatnya di Muara Kuin Kecamatan Banjarmasin Utara, Kalimantan Selatan",
        alamat: "Jl. Alalak Selatan, Alalak Sel., Kec. Banjarmasin Utara, Kota Banjarmasin, Kalimantan Selatan 70126, Indonesia.",
        rating: 5.0,
        imgUrl:
            "https://preview.redd.it/cpgk92bxgw551.jpg?auto=webp&s=530899c64bd57d74133381f24dc30ac8f999f17f"),
    CountryModel(
        namaWisata: "Sabilal Muhtadin",
        namaKota: "Banjarmasin",
        label: "Terbaru",
        deskripsi: "pusat kegiatan Islam dan dakwah di Kalimantan Selatan",
        alamat: "Jl. Jenderal Sudirman No. 1, Banjarmasin, Kalimantan Selatan",
        rating: 4.8,
        imgUrl:
            "https://1.bp.blogspot.com/-6OzQ8s6lYu4/W7WVg8XO3MI/AAAAAAAAAWM/5w0A0OZaTzUEWso3MRnE0-e1SuRJpSQfwCK4BGAYYCw/w1200-h630-p-k-no-nu/Slider-3-Masjid_Sabilal_Muhtadin-BanjarmasinTourism.jpg"),
  ];
}
