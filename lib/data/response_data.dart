class ResponseData {
  bool status;
  Data data;

  ResponseData({this.status, this.data});

  ResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Slideshow> slideshow;
  int rdt;
  int pcr;
  List<Infographic> infographic;
  List<Beritas> beritas;
  int population;
  String ratio;
  String percentage;
  Confirmed confirmed;
  Odp odp;
  Odp pdp;
  Odp otg;
  Kecamatan kecamatan;
  List<List> maps;

  Data(
      {this.slideshow,
      this.beritas,
      this.population,
      this.ratio,
      this.percentage,
      this.confirmed,
      this.odp,
      this.pdp,
      this.otg,
      this.kecamatan,
      this.rdt,
      this.pcr,
      this.infographic});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['slideshow'] != null) {
      slideshow = new List<Slideshow>();
      json['slideshow'].forEach((v) {
        slideshow.add(new Slideshow.fromJson(v));
      });
    }
    if (json['infographisc'] != null) {
      infographic = new List<Infographic>();
      json['infographisc'].forEach((v) {
        infographic.add(new Infographic.fromJson(v));
      });
    }
    if (json['beritas'] != null) {
      beritas = new List<Beritas>();
      json['beritas'].forEach((v) {
        beritas.add(new Beritas.fromJson(v));
      });
    }
    population = json['population'];
    ratio = json['ratio'];
    rdt = json['rdt'];
    pcr = json['pcr'];
    percentage = json['percentage'];
    confirmed = json['confirmed'] != null
        ? new Confirmed.fromJson(json['confirmed'])
        : null;
    odp = json['odp'] != null ? new Odp.fromJson(json['odp']) : null;
    pdp = json['pdp'] != null ? new Odp.fromJson(json['pdp']) : null;
    otg = json['otg'] != null ? new Odp.fromJson(json['otg']) : null;
    kecamatan = json['kecamatan'] != null
        ? new Kecamatan.fromJson(json['kecamatan'])
        : null;
    
    if (json['maps'] != null) {
			maps = new List<List>();
			json['maps'].forEach((v) {
        maps.add(List.from([double.parse(v[0]), double.parse(v[1]), v[2]]));
      });
		}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slideshow != null) {
      data['slideshow'] = this.slideshow.map((v) => v.toJson()).toList();
    }
    if (this.beritas != null) {
      data['beritas'] = this.beritas.map((v) => v.toJson()).toList();
    }
    data['population'] = this.population;
    data['ratio'] = this.ratio;
    data['percentage'] = this.percentage;
    if (this.confirmed != null) {
      data['confirmed'] = this.confirmed.toJson();
    }
    if (this.odp != null) {
      data['odp'] = this.odp.toJson();
    }
    if (this.pdp != null) {
      data['pdp'] = this.pdp.toJson();
    }
    if (this.otg != null) {
      data['otg'] = this.otg.toJson();
    }
    if (this.kecamatan != null) {
      data['kecamatan'] = this.kecamatan.toJson();
    }
    return data;
  }
}

class Infographic {
  String image;
  String title;

  Infographic({this.image, this.title});

  Infographic.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}

class Slideshow {
  String url;
  String to;

  Slideshow({this.url, this.to});

  Slideshow.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['to'] = this.to;
    return data;
  }
}

class Beritas {
  String title;
  String image;
  String link;
  String description;

  Beritas({this.title, this.image, this.description, this.link});

  Beritas.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    description = json['description'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['link'] = this.link;
    return data;
  }
}

class Confirmed {
  int total;
  int active;
  int recover;
  int dead;
  Rechange rRechange;

  Confirmed({this.total, this.active, this.recover, this.dead, this.rRechange});

  Confirmed.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    active = json['active'];
    recover = json['recover'];
    dead = json['dead'];
    rRechange = json['__rechange__'] != null
        ? new Rechange.fromJson(json['__rechange__'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['active'] = this.active;
    data['recover'] = this.recover;
    data['dead'] = this.dead;
    if (this.rRechange != null) {
      data['__rechange__'] = this.rRechange.toJson();
    }
    return data;
  }
}

class Rechange {
  int active;
  int recover;
  int dead;

  Rechange({this.active, this.recover, this.dead});

  Rechange.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    recover = json['recover'];
    dead = json['dead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['recover'] = this.recover;
    data['dead'] = this.dead;
    return data;
  }
}

class Odp {
  int total;
  int process;
  int done;
  int dead;
  Change cChange;
  Percentage percentage;

  Odp(
      {this.total,
      this.process,
      this.done,
      this.dead,
      this.cChange,
      this.percentage});

  Odp.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    process = json['process'];
    done = json['done'];
    dead = json['dead'];
    cChange = json['__change__'] != null
        ? new Change.fromJson(json['__change__'])
        : null;
    percentage = json['percentage'] != null
        ? new Percentage.fromJson(json['percentage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['process'] = this.process;
    data['done'] = this.done;
    data['dead'] = this.dead;
    if (this.cChange != null) {
      data['__change__'] = this.cChange.toJson();
    }
    if (this.percentage != null) {
      data['percentage'] = this.percentage.toJson();
    }
    return data;
  }
}

class Change {
  int total;

  Change({this.total});

  Change.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    return data;
  }
}

class Percentage {
  String process;
  String done;
  String dead;

  Percentage({this.process, this.done, this.dead});

  Percentage.fromJson(Map<String, dynamic> json) {
    process = json['process'];
    done = json['done'];
    dead = json['dead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['process'] = this.process;
    data['done'] = this.done;
    data['dead'] = this.dead;
    return data;
  }
}

class Kecamatan {
  Cigugur cigugur;
  Cigugur cijulang;
  Cigugur cimerak;
  Cigugur kalipucang;
  Cigugur langkaplancar;
  Cigugur mangunjaya;
  Cigugur padaherang;
  Cigugur pangandaran;
  Cigugur parigi;
  Cigugur sidamulih;

  Kecamatan(
      {this.cigugur,
      this.cijulang,
      this.cimerak,
      this.kalipucang,
      this.langkaplancar,
      this.mangunjaya,
      this.padaherang,
      this.pangandaran,
      this.parigi,
      this.sidamulih});

  Kecamatan.fromJson(Map<String, dynamic> json) {
    cigugur =
        json['cigugur'] != null ? new Cigugur.fromJson(json['cigugur']) : null;
    cijulang = json['cijulang'] != null
        ? new Cigugur.fromJson(json['cijulang'])
        : null;
    cimerak =
        json['cimerak'] != null ? new Cigugur.fromJson(json['cimerak']) : null;
    kalipucang = json['kalipucang'] != null
        ? new Cigugur.fromJson(json['kalipucang'])
        : null;
    langkaplancar = json['langkaplancar'] != null
        ? new Cigugur.fromJson(json['langkaplancar'])
        : null;
    mangunjaya = json['mangunjaya'] != null
        ? new Cigugur.fromJson(json['mangunjaya'])
        : null;
    padaherang = json['padaherang'] != null
        ? new Cigugur.fromJson(json['padaherang'])
        : null;
    pangandaran = json['pangandaran'] != null
        ? new Cigugur.fromJson(json['pangandaran'])
        : null;
    parigi =
        json['parigi'] != null ? new Cigugur.fromJson(json['parigi']) : null;
    sidamulih = json['sidamulih'] != null
        ? new Cigugur.fromJson(json['sidamulih'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cigugur != null) {
      data['cigugur'] = this.cigugur.toJson();
    }
    if (this.cijulang != null) {
      data['cijulang'] = this.cijulang.toJson();
    }
    if (this.cimerak != null) {
      data['cimerak'] = this.cimerak.toJson();
    }
    if (this.kalipucang != null) {
      data['kalipucang'] = this.kalipucang.toJson();
    }
    if (this.langkaplancar != null) {
      data['langkaplancar'] = this.langkaplancar.toJson();
    }
    if (this.mangunjaya != null) {
      data['mangunjaya'] = this.mangunjaya.toJson();
    }
    if (this.padaherang != null) {
      data['padaherang'] = this.padaherang.toJson();
    }
    if (this.pangandaran != null) {
      data['pangandaran'] = this.pangandaran.toJson();
    }
    if (this.parigi != null) {
      data['parigi'] = this.parigi.toJson();
    }
    if (this.sidamulih != null) {
      data['sidamulih'] = this.sidamulih.toJson();
    }
    return data;
  }
}

class Cigugur {
  int odpProcess;
  int pdpProcess;
  int otgProcess;
  int positifActive;
  int positifRecover;
  int positifDead;
  int population;
  String ratio;
  String percentage;

  Cigugur(
      {this.odpProcess,
      this.pdpProcess,
      this.otgProcess,
      this.positifActive,
      this.positifRecover,
      this.positifDead,
      this.population,
      this.ratio,
      this.percentage});

  Cigugur.fromJson(Map<String, dynamic> json) {
    odpProcess = json['odp_process'];
    pdpProcess = json['pdp_process'];
    otgProcess = json['otg_process'];
    positifActive = json['positif_active'];
    positifRecover = json['positif_recover'];
    positifDead = json['positif_dead'];
    population = json['population'];
    ratio = json['ratio'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['odp_process'] = this.odpProcess;
    data['pdp_process'] = this.pdpProcess;
    data['otg_process'] = this.otgProcess;
    data['positif_active'] = this.positifActive;
    data['positif_recover'] = this.positifRecover;
    data['positif_dead'] = this.positifDead;
    data['population'] = this.population;
    data['ratio'] = this.ratio;
    data['percentage'] = this.percentage;
    return data;
  }
}
