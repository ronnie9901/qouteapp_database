
class QuotesModel
{
  final int? id;
  String quote,author,category;


  QuotesModel({this.id,required this.quote,required  this.author,required  this.category,});

  factory QuotesModel.fromJson(Map json)
  {
    return QuotesModel(quote: json['quote'], author: json['author'], category: json['category'],);
  }
  Map<String, dynamic> toMap() {
    return {

      'quote': quote,
      'author': author,
      'category': category,

    };
  }

  factory QuotesModel.fromMap(Map<String, dynamic> map) {
    return QuotesModel(
      id: map['id'],
      quote: map['quote'],
      author: map['author'],
      category: map['category'],
       // Convert from integer to boolean
    );
  }
}
