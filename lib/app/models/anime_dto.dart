class AnimeDto {
  final String title;
  final String description;
  final String date;
  final String link;

  AnimeDto({
    required this.title,
    required this.description,
    required this.date,
    required this.link,
  });
  factory AnimeDto.fromJson(Map<String, dynamic> json) => AnimeDto(
        title: json["title"]["rendered"],
        description: json["content"]["rendered"],
        date: json["date"],
        link: json["link"],
      );
}
