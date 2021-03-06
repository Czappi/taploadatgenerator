import 'dart:convert';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import 'package:taploadatgenerator/data.dart';

class EditorPage extends StatefulWidget {
  final String link;
  const EditorPage({Key? key, required this.link}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  Map<String, dynamic> viccesJson = {
    "link": "",
    "firstname": "",
    "lastname": "",
    "secondname": "",
    "showsecondname": true,
    "img": "",
    "qoute": "",
    "ytid": "",
    "aboutyou": "",
  };
  Map<String, dynamic> simaJson = {
    "link": "",
    "firstname": "",
    "lastname": "",
    "secondname": "",
    "showsecondname": true,
    "img": "",
    "qoute": "",
    "ytid": "",
    "aboutyou": "",
  };
  String title = '';
  String viccesytLink = 'https://www.youtube.com/watch?v=Qmwa0r9D3NE';
  String simaytLink = 'https://www.youtube.com/watch?v=Qmwa0r9D3NE';
  final HtmlEditorController simacontroller = HtmlEditorController();
  final HtmlEditorController viccescontroller = HtmlEditorController();

  String imageText = '';

  int stage = 1;

  @override
  void initState() {
    final data = classlist.firstWhere(
      (element) => element['link'] == widget.link,
    );
    final splittedName = data['name']?.split(' ') ?? ['', ''];

    final initialFirstname = splittedName[1];
    final initialLastname = splittedName[0];
    var initialSecondname = "";
    if (splittedName.length == 3) {
      initialSecondname = splittedName[2];
    }

    viccesJson['link'] = widget.link;
    viccesJson["firstname"] = initialFirstname;
    viccesJson["lastname"] = initialLastname;
    viccesJson["secondname"] = initialSecondname;

    simaJson['link'] = widget.link;
    simaJson["firstname"] = initialFirstname;
    simaJson["lastname"] = initialLastname;
    simaJson["secondname"] = initialSecondname;

    title = data['name'] ?? 'valami baj van';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    if (stage == 1) {
      child = stage1();
    } else if (stage == 2) {
      child = stage2();
    } else if (stage == 3) {
      child = stage3();
    } else if (stage == 4) {
      child = stage4();
    } else if (stage == 35) {
      child = stage35();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: child,
    );
  }

  Widget editor({
    required String title,
    required Map<String, dynamic> map,
    required String ytLink,
    required ValueChanged<String> ytLinkCallback,
    required ValueChanged<String> lastnameCallback,
    required ValueChanged<String> firstnameCallback,
    required ValueChanged<String> secondnameCallback,
    required ValueChanged<String> qouteCallback,
    required ValueChanged<bool?> showSecondnameCallback,
  }) {
    String initialFirstname = map['firstname'];
    String initialLastname = map['lastname'];
    String initialSecondname = map['secondname'];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          TextFormField(
            initialValue: initialLastname,
            decoration: const InputDecoration(labelText: "Csal??dn??v"),
            onChanged: lastnameCallback,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            initialValue: initialFirstname,
            decoration: const InputDecoration(labelText: "Keresztn??v"),
            onChanged: firstnameCallback,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            initialValue: initialSecondname,
            decoration: const InputDecoration(labelText: "Harmadik n??v"),
            onChanged: secondnameCallback,
          ),
          CheckboxListTile(
            value: map["showsecondname"],
            onChanged: showSecondnameCallback,
            title: const Text("L??tszodjon a harmadik n??v?"),
          ),
          TextFormField(
            initialValue: map["qoute"],
            decoration: const InputDecoration(
                labelText: "Catchphrase vagy id??zet vagy ilyenek"),
            onChanged: qouteCallback,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            initialValue: ytLink,
            decoration:
                const InputDecoration(labelText: "H??tt??rzene Youtube link"),
            onChanged: ytLinkCallback,
          ),
          const SizedBox(
            height: 8,
          ),

          // kim??soland?? k??d
          const SizedBox(
            height: 16,
          ),
          //code(map),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget code(Map map) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: SelectableText(
        json.encode(map),
      ),
    );
  }

  Widget htmlEditor(HtmlEditorController controller, Map map) {
    return Expanded(
      child: HtmlEditor(
        controller: controller,
        callbacks: Callbacks(
          onChangeContent: (htmlcode) {
            setState(() {
              map['aboutyou'] = htmlcode;
            });
          },
          onChangeCodeview: (htmlcode) {
            setState(() {
              map['aboutyou'] = htmlcode;
            });
          },
        ),
        htmlEditorOptions: const HtmlEditorOptions(
          hint: 'Your text here...',
          shouldEnsureVisible: true,
          //initialText: "<p>text content initial, if any</p>",
        ),
        htmlToolbarOptions: const HtmlToolbarOptions(
          toolbarPosition: ToolbarPosition.aboveEditor, //by default
          toolbarType: ToolbarType.nativeScrollable, //by default
        ),
      ),
    );
  }

  Widget stage1() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent[100],
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 40),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Teend??k - 1/4",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Text(
                  "El??sz??r ki kell t??lteni a komoly oldalad inform??ci??it. (milyen egy??rtelm??) "
                  "Azt??n a dugi oldalad??t. Figyelj, hogy j??l t??lt??d ki!",
                ),
                /* const Text(
                  'Azt??n csin??lhatsz k??t j?? kis "about me" r??sz (aranyk??p??seknek van nevezve, mert nem volt jobb ??tletem). '
                  'Ide fog ker??lni minden "szem??lyes", sz??val a k??pek, vide??k amiket akarsz kirakani'
                  ''
                  //'Ha k??pet akarsz berakni oda akkor hazn??ld a k??vetkez?? for'
                  'Az ide tartoz?? dolgokat ott helyben r??szletesen le??rom',
                ),*/
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orangeAccent[200],
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fontos!",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Text(
                  "Az el??r??si??t mindk??t oldaladn??l (amit a tan??rok is l??tnak ??s a dugin??l is) haszn??lva lesz!",
                )
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: TextFormField(
              initialValue: simaJson['link'],
              decoration: const InputDecoration(
                  labelText: "El??r??si ??t (pl.: kszj.hu/ez-az-eleresi-ut)"),
              onChanged: (value) {
                setState(() {
                  var formattedValue = value
                      .toLowerCase()
                      .replaceAll(RegExp(r'[??]'), 'e')
                      .replaceAll(RegExp(r'[??]'), 'i')
                      .replaceAll(RegExp(r'[??]'), 'a')
                      .replaceAll(RegExp(r'[??????]'), 'o')
                      .replaceAll(RegExp(r'[??????]'), 'u')
                      .replaceAll(RegExp(r' '), '');
                  simaJson['link'] = formattedValue;
                  simaJson['link'] = formattedValue;
                });
              },
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
        SliverToBoxAdapter(
          child: editor(
            title: "komoly rendes oldal",
            map: simaJson,
            ytLink: simaytLink,
            ytLinkCallback: (String value) {
              var id = convertUrlToId(value);
              setState(() {
                simaJson['ytid'] = id;
              });
            },
            firstnameCallback: (String value) {
              setState(() {
                simaJson['firstname'] = value;
              });
            },
            lastnameCallback: (String value) {
              setState(() {
                simaJson['lastname'] = value;
              });
            },
            secondnameCallback: (String value) {
              setState(() {
                simaJson['secondname'] = value;
              });
            },
            showSecondnameCallback: (bool? value) {
              setState(() {
                simaJson['showsecondname'] = value ?? true;
              });
            },
            qouteCallback: (String value) {
              setState(() {
                simaJson['qoute'] = value;
              });
            },
          ),
        ),
        SliverToBoxAdapter(
          child: editor(
            title: "dugi oldal",
            map: viccesJson,
            ytLink: viccesytLink,
            ytLinkCallback: (String value) {
              setState(() {
                viccesJson['ytlink'] = value;
              });
            },
            firstnameCallback: (String value) {
              setState(() {
                viccesJson['firstname'] = value;
              });
            },
            lastnameCallback: (String value) {
              setState(() {
                viccesJson['lastname'] = value;
              });
            },
            secondnameCallback: (String value) {
              setState(() {
                viccesJson['secondname'] = value;
              });
            },
            showSecondnameCallback: (bool? value) {
              setState(() {
                viccesJson['showsecondname'] = value ?? true;
              });
            },
            qouteCallback: (String value) {
              setState(() {
                viccesJson['qoute'] = value;
              });
            },
          ),
        ),
        /*
        SliverToBoxAdapter(
          child: Column(
            children: [
              uploadImageButton(viccesJson),
              uploadedImage(imageText),
            ],
          ),
        ),*/
        SliverToBoxAdapter(
          child: button("K??vetkez??", 2),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 50,
          ),
        )
      ],
    );
  }

  Widget stage35() {
    return Row(
      children: [
        button("El??z??", 2),
        button("K??vetkez??", 3, extra: () {
          viccescontroller.reloadWeb();
        }),
      ],
    );
  }

  Widget stage2() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent[100],
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 40),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Teend??k - 2/4",
                style: Theme.of(context).textTheme.headline4,
              ),
              const Text(
                'Most egy kis tervezget??s j??n. Meg kell csin??lnod a tan??rok ??ltal l??that?? "about me"/aranyk??p??sek '
                '(aranyk??p??seknek van nevezve, mert nem volt jobb ??tletem) '
                "r??szedet",
              ),
              const Text(
                  'Ide fog ker??lni minden "szem??lyes", sz??val a k??pek, vide??k amiket akarsz kirakni \n'),
              InkWell(
                onTap: () {
                  simacontroller.reloadWeb();
                },
                child: const Text(
                    "Ha fur??n viselkedne a szerkeszt?? nyomj erre! (ilyenkor elt??nik minden v??ltoz??s)"),
              ),
              const Text(
                  "Lehet m??s szerkezt??vel jobban j??rsz. Mindegy igaz??b??l miaz csak egy html f??jl j??jj??n ki bel??le"),
            ],
          ),
        ),
        htmlEditor(simacontroller, simaJson),
        Row(
          children: [
            button("El??z??", 1),
            button("K??vetkez??", 35, extra: () {
              viccescontroller.reloadWeb();
            }),
          ],
        ),
      ],
    );
  }

  Widget stage3() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent[100],
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 40),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Teend??k - 3/4",
                style: Theme.of(context).textTheme.headline4,
              ),
              const Text(
                'Most j??n a m??ka. Meg kell csin??lnod a dugi "about me"/aranyk??p??sek '
                '(aranyk??p??seknek van nevezve, mert nem volt jobb ??tletem) '
                "r??szedet",
              ),
              const Text(
                  'Ide fog ker??lni minden, de t??nyleg minden amit akarsz, sz??val a k??pek, vide??k j??jjenek \n'),
              InkWell(
                onTap: () {
                  viccescontroller.reloadWeb();
                },
                child: const Text(
                    "Ha fur??n viselkedne a szerkeszt?? nyomj erre! (ilyenkor elt??nik minden v??ltoz??s)"),
              ),
              const Text(
                  "Lehet m??s szerkezt??vel jobban j??rsz. Mindegy igaz??b??l miaz csak egy html f??jl j??jj??n ki bel??le"),
            ],
          ),
        ),
        htmlEditor(viccescontroller, viccesJson),
        Row(
          children: [
            button("El??z??", 35, extra: () {
              simacontroller.reloadWeb();
            }),
            button("K??vetkez??", 4, extra: () {}),
          ],
        ),
      ],
    );
  }

  Widget stage4() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent[100],
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 40),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Teend??k - 4/4",
                style: Theme.of(context).textTheme.headline4,
              ),
              const Text(
                'V??geszt??l is a nehez??vel! M??r csak le kell t??ltened a f??jlt ??s elk??ldeni nekem vagy az oszt??lycsoportba',
              ),
            ],
          ),
        ),
        downloadbutton(viccesJson, simaJson),
        button("El??z??", 3, extra: () {
          //viccescontroller.enable();
        }),
      ],
    );
  }

  Widget downloadbutton(Map funnyJson, Map normalJson) {
    return OutlinedButton(
      onPressed: () {
        downloadFile(funnyJson, normalJson);
      },
      child: const Text("Let??lt??s"),
    );
  }

  Widget button(String text, int to, {Function? extra}) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          stage = to;
        });
        extra?.call();
      },
      child: Text(text),
    );
  }

  Widget uploadImageButton(Map map) {
    return OutlinedButton(
      onPressed: () {
        uploadImage(map);
      },
      child: const Text("Profilk??p felt??lt??se"),
    );
  }

  Widget uploadedImage(String img) {
    if (img != "" || img != "/among-us.gif") {
      var decodedimg =
          base64Decode(img.replaceAll("data:image/png;base64, ", ""));
      return Image.memory(decodedimg);
    } else {
      return const Text("M??g nincs k??p felt??ltve");
    }
  }

  Future<void> uploadImage(Map map) async {
    var picked = await FilePicker.platform.pickFiles();

    if (picked != null && picked.isSinglePick) {
      var ext = picked.files[0].extension;
      var bytes = picked.files[0].bytes;
      var imgtext = '';

      if (bytes != null && ext != null) {
        switch (ext) {
          case "jpeg":
            imgtext = "data:image/jpeg;base64 ${base64Encode(bytes)}";
            break;
          case "jpg":
            imgtext = "data:image/jpeg;base64 ${base64Encode(bytes)}";
            break;
          case "gif":
            imgtext = "data:image/gif;base64 ${base64Encode(bytes)}";
            break;
          // default: png
          default:
            imgtext = "data:image/png;base64 ${base64Encode(bytes)}";
        }
      }

      setState(() {
        map["img"] = imgtext;
      });
    }
  }

  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  static void downloadFile(Map funnyJson, Map normalJson) {
    final content = json.encode({
      "normal": normalJson,
      "funny": funnyJson,
    });
    final anchor =
        html.AnchorElement(href: 'data:text/json;charset=utf-8,$content')
          ..setAttribute("download", "${normalJson['link']}.json")
          ..click();
  }
}
