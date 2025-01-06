class MessageModel{
  String?type;
  String?filePath;
  String?text;
  String?date;
  Duration?duration;
  MessageModel({
    this.type,
    this.filePath,
    this.text,this.duration,
    this.date,
});
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      MessageModel(
        type: json["type"],
        filePath: json["filePath"] ?? "",
        text: json["text"]??"",
        date: (json["date"] ?? ""),
       // duration: json["duration"]??Duration(seconds: 1)
      );
  Map<String, dynamic> toJson() => {
    "type": type,
    "filePath": filePath,
    "text":text,
    "date":date,
   // "duration":duration,
  };
}