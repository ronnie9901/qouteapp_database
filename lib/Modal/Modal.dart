
class QuotesModel
{
  final int? id;

  String quote,author,category;
       bool fav;


  QuotesModel({this.id,required this.quote,required  this.author,required  this.category,   this.fav = false});

  factory QuotesModel.fromJson(Map json)
  {
    return QuotesModel(quote: json['quote'], author: json['author'], category: json['category'], );
  }
  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'author': author,
      'category': category,
      'is_favorite':fav ? 1:0
    };
  }

  factory QuotesModel.fromMap(Map map) {
    return QuotesModel(
      id: map['id'],
      quote: map['quote'],
      author: map['author'],
      category: map['category'],
       fav: map['is_favorite']
       // Convert from integer to boolean
    );
  }
}
