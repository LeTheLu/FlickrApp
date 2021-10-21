class Flickr{
  Photos? photos;
  String? stat;

  Flickr({this.photos, this.stat});

  factory Flickr.fromJson(Map<String, dynamic> parseJson){
    return Flickr(
        photos: Photos.fromJson(parseJson['photos']),
        stat: parseJson['stat']
    );
  }

}

class Photos {
  int? page;
  int? pages;
  int? perpage;
  int? total;
  List<Photo>? photo;

  Photos({this.page, this.pages, this.perpage, this.total, this.photo});

  factory Photos.fromJson(Map<String, dynamic> parseJson){
    var list = parseJson['photo'] as List;
    List<Photo> photoList = list.map((e) => Photo.fromJson(e)).toList();

    return Photos(
      page: parseJson['page'],
      pages :  parseJson['pages'],
      perpage : parseJson['perpage'],
      total : parseJson['total'],
      photo: photoList,
    );

  }

}

class Photo{
  String? id;
  String? owner;
  String? secret;
  String? server;
  int? farm;
  String? title;
  int? ispublic;
  int? isfriend;
  int? isfamily;
  String? views;
  String? media;
  String? mediaStatus;
  String? urlSq;
  int? heightSq;
  int? widthSq;
  String? urlT;
  int? heightT;
  int? widthT;
  String? urlS;
  int? heightS;
  int? widthS;
  String? urlQ;
  int? heightQ;
  int? widthQ;
  String? urlM;
  int? heightM;
  int? widthM;
  String? urlN;
  int? heightN;
  int? widthN;
  String? urlZ;
  int? heightZ;
  int? widthZ;
  String? urlC;
  int? heightC;
  int? widthC;
  String? urlL;
  int? heightL;
  int? widthL;
  String? urlO;
  int? heightO;
  int? widthO;
  String? pathalias;

  Photo({
    this.id,
    this.owner,
    this.secret,
    this.server,
    this.farm,
    this.title,
    this.ispublic,
    this.isfriend,
    this.isfamily,
    this.views,
    this.media,
    this.mediaStatus,
    this.urlSq,
    this.heightSq,
    this.widthSq,
    this.urlT,
    this.heightT,
    this.widthT,
    this.urlS,
    this.heightS,
    this.widthS,
    this.urlQ,
    this.heightQ,
    this.widthQ,
    this.urlM,
    this.heightM,
    this.widthM,
    this.urlN,
    this.heightN,
    this.widthN,
    this.urlZ,
    this.heightZ,
    this.widthZ,
    this.urlC,
    this.heightC,
    this.widthC,
    this.urlL,
    this.heightL,
    this.widthL,
    this.pathalias,
    this.urlO,
    this.heightO,
    this.widthO});

  factory Photo.fromJson( json){
    return Photo(
      id : json['id'],
      owner : json['owner'],
      secret : json['secret'],
      server : json['server'],
      farm : json['farm'],
      title : json['title'],
      ispublic : json['ispublic'],
      isfriend : json['isfriend'],
      isfamily : json['isfamily'],
      views : json['views'],
      media : json['media'],
      mediaStatus : json['media_status'],
      urlSq : json['url_sq'],
      heightSq : json['height_sq'],
      widthSq : json['width_sq'],
      urlT : json['url_t'],
      heightT : json['height_t'],
      widthT : json['width_t'],
      urlS : json['url_s'],
      heightS : json['height_s'],
      widthS : json['width_s'],
      urlQ : json['url_q'],
      heightQ : json['height_q'],
      widthQ : json['width_q'],
      urlM : json['url_m'],
      heightM : json['height_m'],
      widthM : json['width_m'],
      urlN : json['url_n'],
      heightN : json['height_n'],
      widthN : json['width_n'],
      urlZ : json['url_z'],
      heightZ : json['height_z'],
      widthZ : json['width_z'],
      urlC : json['url_c'],
      heightC : json['height_c'],
      widthC : json['width_c'],
      urlL : json['url_l'],
      heightL : json['height_l'],
      widthL : json['width_l'],
      pathalias : json['pathalias'],
      urlO : json['url_o'],
      heightO : json['height_o'],
      widthO : json['width_o'],
    );

  }

}