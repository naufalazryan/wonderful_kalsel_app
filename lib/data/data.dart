import 'package:wonderful_kalsel/model/country_model.dart';
import 'package:wonderful_kalsel/model/popular_tours_model.dart';

List<CountryModel> getCountries() {
  return [
    CountryModel(
        namaWisata: "Gunung Meratus",
        label: "Teratas",
        deskripsi: "Meratus merupakan kawasan pegunungan yang berada di tenggara Pulau Kalimantan serta membelah Provinsi Kalimantan Selatan menjadi dua. Pegunungan ini membentang sepanjang ± 600 km² dari arah baratdaya-timulaut dan membelok ke arah utara hingga perbatasan provinsi Kalimantan Tengah dan Kalimantan Timur.",
        alamat: "HST",
        rating: 4.7,
        imgUrl:
            "https://i.pinimg.com/564x/5d/1c/a7/5d1ca70dc0bf425ac0639e401cec74f9.jpg"),
    CountryModel(
        namaWisata: "Pasar Terapung",
        label: "Populer",
        deskripsi: " pasar tradisional yang berada di atas Sungai Barito, tepatnya di Muara Kuin Kecamatan Banjarmasin Utara, Kalimantan Selatan",
        alamat: "Banjarmasin",
        rating: 5.0,
        imgUrl:
            "https://preview.redd.it/cpgk92bxgw551.jpg?auto=webp&s=530899c64bd57d74133381f24dc30ac8f999f17f"),
    CountryModel(
        namaWisata: "Masjid SM",
        label: "Terbaru",
        deskripsi: "pusat kegiatan Islam dan dakwah di Kalimantan Selatan",
        alamat: "Banjarmasin",
        rating: 4.8,
        imgUrl:
            "https://1.bp.blogspot.com/-6OzQ8s6lYu4/W7WVg8XO3MI/AAAAAAAAAWM/5w0A0OZaTzUEWso3MRnE0-e1SuRJpSQfwCK4BGAYYCw/w1200-h630-p-k-no-nu/Slider-3-Masjid_Sabilal_Muhtadin-BanjarmasinTourism.jpg"),
    CountryModel(
        namaWisata: "Danau Seran",
        label: "Teratas",
        deskripsi: "",
        alamat: "Banjarbaru",
        rating: 5.0,
        imgUrl:
            "https://www.celebes.co/borneo/wp-content/uploads/2022/09/Sekilas-Tentang-Danau-Seran.jpg"),

  ];
}

List<PopularTourModel> getPopularTours() {
  return [
    PopularTourModel(
      imgUrl:
          "https://kawanpuan.com/wp-content/uploads/2022/10/Wisata-Banjarbaru.jpg",
      title: "Alaska Park",
      desc: "",
      price: "Rp 30.000",
      rating: 4.3,
    ),
  ];
}
