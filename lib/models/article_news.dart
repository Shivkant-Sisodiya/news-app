class NewsModel {
  List<Children>? children;

  NewsModel({this.children});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  Data? data;

  Children({this.data});

  Children.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? title;
  String? thumbnail;
  int? createdUtc;
  Preview? preview;

  Data({this.title, this.thumbnail, this.createdUtc, this.preview});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'];
    createdUtc = json['created_utc'];
    preview =
        json['preview'] != null ? new Preview.fromJson(json['preview']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['created_utc'] = this.createdUtc;
    if (this.preview != null) {
      data['preview'] = this.preview!.toJson();
    }
    return data;
  }
}

class Preview {
  List<Images>? images;

  Preview({this.images});

  Preview.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  Source? source;
  List<Resolutions>? resolutions;
  String? id;

  Images({this.source, this.resolutions, this.id});

  Images.fromJson(Map<String, dynamic> json) {
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
    if (json['resolutions'] != null) {
      resolutions = <Resolutions>[];
      json['resolutions'].forEach((v) {
        resolutions!.add(new Resolutions.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }
    if (this.resolutions != null) {
      data['resolutions'] = this.resolutions!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Source {
  String? url;
  int? width;
  int? height;

  Source({this.url, this.width, this.height});

  Source.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Resolutions {
  String? url;
  int? width;
  int? height;

  Resolutions({this.url, this.width, this.height});

  Resolutions.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}