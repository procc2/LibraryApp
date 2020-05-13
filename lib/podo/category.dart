import 'package:libraryapp/util/consts.dart';
import 'package:intl/intl.dart';

class CategoryFeed {
  String version;
  String encoding;
  Feed feed;

  CategoryFeed({this.version, this.encoding, this.feed});

  CategoryFeed.fromJson(List<dynamic> json) {
    // version = json['version'];
    // encoding = json['encoding'];
    feed = json != null ? new Feed.fromJson(json) : null;
  }

  CategoryFeed.clone(CategoryFeed cloneFeed){
    this.version = cloneFeed.version;
    this.encoding = cloneFeed.encoding;
    this.feed = Feed.clone(cloneFeed.feed);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['encoding'] = this.encoding;
    if (this.feed != null) {
      data['feed'] = this.feed.toJson();
    }
    return data;
  }
}

class Feed {
  String xmlLang;
  String xmlns;
  String xmlnsDcterms;
  String xmlnsThr;
  String xmlnsApp;
  String xmlnsOpensearch;
  String xmlnsOpds;
  String xmlnsXsi;
  String xmlnsOdl;
  String xmlnsSchema;
  Id id;
  Id title;
  Id updated;
  Id icon;
  Author author;
  List<Link> link;
  Id opensearchTotalResults;
  Id opensearchItemsPerPage;
  Id opensearchStartIndex;
  List<Entry> entry;

  Feed(
      {this.xmlLang,
        this.xmlns,
        this.xmlnsDcterms,
        this.xmlnsThr,
        this.xmlnsApp,
        this.xmlnsOpensearch,
        this.xmlnsOpds,
        this.xmlnsXsi,
        this.xmlnsOdl,
        this.xmlnsSchema,
        this.id,
        this.title,
        this.updated,
        this.icon,
        this.author,
        this.link,
        this.opensearchTotalResults,
        this.opensearchItemsPerPage,
        this.opensearchStartIndex,
        this.entry});

  Feed.fromJson(List<dynamic> json) {
    if (json != null) {
      String t = json.runtimeType.toString();
      if(t == "List<dynamic>" || t == "_GrowableList<dynamic>"){
        entry = new List<Entry>();
        json.forEach((v) {
          entry.add(new Entry.fromJson(v));
        });
      }else{
        entry = new List<Entry>();
        // entry.add(new Entry.fromJson(json));
      }
    }
  }

  Feed.clone(Feed source){
    this.entry = new List.from(source.entry);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xml:lang'] = this.xmlLang;
    data[r'xmlns'] = this.xmlns;
    data[r'xmlns$dcterms'] = this.xmlnsDcterms;
    data[r'xmlns$thr'] = this.xmlnsThr;
    data[r'xmlns$app'] = this.xmlnsApp;
    data[r'xmlns$opensearch'] = this.xmlnsOpensearch;
    data[r'xmlns$opds'] = this.xmlnsOpds;
    data[r'xmlns$xsi'] = this.xmlnsXsi;
    data[r'xmlns$odl'] = this.xmlnsOdl;
    data[r'xmlns$schema'] = this.xmlnsSchema;
    if (this.id != null) {
      data['id'] = this.id.toJson();
    }
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    if (this.updated != null) {
      data['updated'] = this.updated.toJson();
    }
    if (this.icon != null) {
      data['icon'] = this.icon.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    if (this.link != null) {
      data['link'] = this.link.map((v) => v.toJson()).toList();
    }
    if (this.opensearchTotalResults != null) {
      data[r'opensearch$totalResults'] = this.opensearchTotalResults.toJson();
    }
    if (this.opensearchItemsPerPage != null) {
      data[r'opensearch$itemsPerPage'] = this.opensearchItemsPerPage.toJson();
    }
    if (this.opensearchStartIndex != null) {
      data[r'opensearch$startIndex'] = this.opensearchStartIndex.toJson();
    }
    if (this.entry != null) {
      data['entry'] = this.entry.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Id {
  String t;

  Id({this.t});

  Id.fromJson(String string) {
    t = string;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[r'$t'] = this.t;
    return data;
  }
}

class Author {
  Id id;
  Id name;

  Author({this.name, this.id});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['author_name'] != null ? new Id.fromJson(json['author_name']) : null;
    id = json['author_id'] != null ? new Id.fromJson(json['author_id'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['author_name'] = this.name.toJson();
    }
    if (this.id != null) {
      data['author_id'] = this.id.toJson();
    }
    return data;
  }
}

class Link {
  String rel;
  String type;
  String href;
  String title;
  String opdsActiveFacet;
  String opdsFacetGroup;
  String thrCount;

  Link(
      {this.rel,
        this.type,
        this.href,
        this.title,
        this.opdsActiveFacet,
        this.opdsFacetGroup,
        this.thrCount});

  Link.fromJson(Map<String, dynamic> json) {
    rel = json['rel'];
    type = json['type'];
    href = json['href'];
    title = json['title'];
    opdsActiveFacet = json['opds:activeFacet'];
    opdsFacetGroup = json['opds:facetGroup'];
    thrCount = json['thr:count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rel'] = this.rel;
    data['type'] = this.type;
    data['href'] = this.href;
    data['title'] = this.title;
    data['opds:activeFacet'] = this.opdsActiveFacet;
    data['opds:facetGroup'] = this.opdsFacetGroup;
    data['thr:count'] = this.thrCount;
    return data;
  }
}

class Entry {
  Id title;
  Id id;
  Author author;
  Publisher publisher;
  DateTime updated;
  Id categoryId;
  Id dctermsPublisher;
  Id dctermsIssued;
  Id summary;
  List<Category> category;
  List<FileUpload> files;
  SchemaSeries schemaSeries;
  String imageUrl;

  DateTime rentalDay;

  Entry(
      {this.title,
        this.id,
        this.author,
        this.publisher,
        this.updated,
        this.categoryId,
        this.dctermsPublisher,
        this.dctermsIssued,
        this.summary,
        this.category,
        this.files,
        this.schemaSeries});

  Entry.fromJson(Map<String, dynamic> json) {
    title = json['book_name'] != null ? new Id.fromJson(json['book_name']) : null;
    id = json['book_id'] != null ? new Id.fromJson(json['book_id'].toString()) : null;
    // categoryId = json['id_dm'] != null ? new Id.fromJson(json['id_dm'].toString()) : null;
    if(json['author'] != null){
      if(json['author'].runtimeType.toString() == "List<dynamic>"){
        author = Author.fromJson(json['author'][0]);
      }else{
        author = Author.fromJson(json['author']);
      }
    }
    if(json['publisher'] != null){
      if(json['publisher'].runtimeType.toString() == "List<dynamic>"){
        publisher = Publisher.fromJson(json['publisher'][0]);
      }else{
        publisher = Publisher.fromJson(json['publisher']);
      }
    }
    // publisher = json['ten_NXB'] != null ? new Id.fromJson(json['ten_NXB']) : null;
    updated = json['updated_at'] != null ? DateFormat("yyyy-MM-dd").parse(json['updated_at'].trim()) : null;
    
    summary = json['book_description'] != null ? new Id.fromJson(json['book_description']) : null;
    if (json['categories'] != null) {
      String t = json['categories'].runtimeType.toString();
      if(t == "List<dynamic>" || t == "_GrowableList<dynamic>"){
        category = new List<Category>();
        json['categories'].forEach((v) {
          category.add(new Category.fromJson(v));
        });
      }else{
        category = new List<Category>();
        category.add(new Category.fromJson(json['categories']));
      }
    }

    if (json['images'] != null) {
      String t = json['images'].runtimeType.toString();
      if(t == "List<dynamic>" || t == "_GrowableList<dynamic>"){
        files = new List<FileUpload>();
        json['images'].forEach((v) {
          files.add(new FileUpload.fromJson(v));
        });
      }else{
        files = new List<FileUpload>();
        files.add(new FileUpload.fromJson(json['images']));
      }
    }
    // rentalDay = json['ngay_muon'] != null ? DateFormat("yyyy-MM-dd").parse(json['ngay_muon'].trim()) : null;
    // imageUrl = json['image'] != null ? Constants.apiAssetUrl+(json['anh_ap'].trim()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.title != null) {
      data['book_name'] = this.title.t;
    }
    if (this.id != null) {
      data['book_id'] = this.id.t;
    }
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    if (this.publisher != null) {
      data['publisher'] = this.publisher.toJson();
    }
    if (this.updated != null) {
      data['updated'] = this.updated.toString();
    }
    // if (this.dctermsLanguage != null) {
    //   data[r'dcterms$language'] = this.dctermsLanguage.toJson();
    // }
    if (this.categoryId != null) {
      data['id_dm'] = this.categoryId.t;
    }
    if (this.dctermsIssued != null) {
      data[r'dcterms$issued'] = this.dctermsIssued.toJson();
    }
    if (this.summary != null) {
      data['chi_tiet_ap'] = this.summary.t;
    }
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.imageUrl != null) {
      data['anh_ap'] = this.imageUrl.replaceAll(Constants.assetUrl, "");
    }
    if (this.schemaSeries != null) {
      data[r'schema$Series'] = this.schemaSeries.toJson();
    }
    return data;
  }
}

class Publisher {
  Id name;
  Id id;

  Publisher({this.name, this.id});

  Publisher.fromJson(Map<String, dynamic> json) {
    name = json['book_name'] != null ? new Id.fromJson(json['book_name']) : null;
    id = json['book_id'] != null ? new Id.fromJson(json['book_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['book_name'] = this.name.toJson();
    }
    if (this.id != null) {
      data['book_id'] = this.id.toJson();
    }
    return data;
  }
}

class Category {
  String label;

  Category({this.label});

  Category.fromJson(Map<String, dynamic> json) {
    label = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.label;
    return data;
  }
}

class FileUpload {
  String type;
  String rel;
  String title;
  String ext;

  FileUpload({this.type, this.rel, this.title, this.ext});

  FileUpload.fromJson(Map<String, dynamic> json) {
    type = json['type'] != null ? json['type'] :null ;
    rel = json['book_id'] != null ? json['book_id'].toString() : null ;
    title = json['name'] != null ? Constants.apiAssetUrl + json['name'].toString().trim() : null;
    ext = json['ext'] != null ? json['book_id'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['book_id'] = this.rel;
    data['name'] = this.title;
    data['ext'] = this.ext;
    return data;
  }
}

class SchemaSeries {
  String schemaPosition;
  String schemaName;
  String schemaUrl;

  SchemaSeries({this.schemaPosition, this.schemaName, this.schemaUrl});

  SchemaSeries.fromJson(Map<String, dynamic> json) {
    schemaPosition = json[r'schema:position'];
    schemaName = json[r'schema:name'];
    schemaUrl = json[r'schema:url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[r'schema:position'] = this.schemaPosition;
    data[r'schema:name'] = this.schemaName;
    data[r'schema:url'] = this.schemaUrl;
    return data;
  }
}
