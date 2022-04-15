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
            decoration: const InputDecoration(labelText: "Családnév"),
            onChanged: lastnameCallback,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            initialValue: initialFirstname,
            decoration: const InputDecoration(labelText: "Keresztnév"),
            onChanged: firstnameCallback,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            initialValue: initialSecondname,
            decoration: const InputDecoration(labelText: "Harmadik név"),
            onChanged: secondnameCallback,
          ),
          CheckboxListTile(
            value: map["showsecondname"],
            onChanged: showSecondnameCallback,
            title: const Text("Látszodjon a harmadik név?"),
          ),
          TextFormField(
            initialValue: map["qoute"],
            decoration: const InputDecoration(
                labelText: "Catchphrase vagy idézet vagy ilyenek"),
            onChanged: qouteCallback,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            initialValue: ytLink,
            decoration:
                const InputDecoration(labelText: "Háttérzene Youtube link"),
            onChanged: ytLinkCallback,
          ),
          const SizedBox(
            height: 8,
          ),

          // kimásolandó kód
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
                  "Teendők - 1/4",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Text(
                  "Először ki kell tölteni a komoly oldalad információit. (milyen egyértelmű) "
                  "Aztán a dugi oldaladét. Figyelj, hogy jól töltöd ki!",
                ),
                /* const Text(
                  'Aztán csinálhatsz két jó kis "about me" rész (aranyköpéseknek van nevezve, mert nem volt jobb ötletem). '
                  'Ide fog kerülni minden "személyes", szóval a képek, videók amiket akarsz kirakani'
                  ''
                  //'Ha képet akarsz berakni oda akkor haználd a következő for'
                  'Az ide tartozó dolgokat ott helyben részletesen leírom',
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
                  "Az elérésiút mindkét oldaladnál (amit a tanárok is látnak és a duginál is) használva lesz!",
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
                  labelText: "Elérési út (pl.: kszj.hu/ez-az-eleresi-ut)"),
              onChanged: (value) {
                setState(() {
                  var formattedValue = value
                      .toLowerCase()
                      .replaceAll(RegExp(r'[é]'), 'e')
                      .replaceAll(RegExp(r'[í]'), 'i')
                      .replaceAll(RegExp(r'[á]'), 'a')
                      .replaceAll(RegExp(r'[öóő]'), 'o')
                      .replaceAll(RegExp(r'[üúű]'), 'u')
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
          child: button("Következő", 2),
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
        button("Előző", 2),
        button("Következő", 3, extra: () {
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
                "Teendők - 2/4",
                style: Theme.of(context).textTheme.headline4,
              ),
              const Text(
                'Most egy kis tervezgetés jön. Meg kell csinálnod a tanárok által látható "about me"/aranyköpések '
                '(aranyköpéseknek van nevezve, mert nem volt jobb ötletem) '
                "részedet",
              ),
              const Text(
                  'Ide fog kerülni minden "személyes", szóval a képek, videók amiket akarsz kirakni \n'),
              InkWell(
                onTap: () {
                  simacontroller.reloadWeb();
                },
                child: const Text(
                    "Ha furán viselkedne a szerkesztő nyomj erre! (ilyenkor eltünik minden változás)"),
              ),
              const Text(
                  "Lehet más szerkeztővel jobban jársz. Mindegy igazából miaz csak egy html fájl jöjjön ki belőle"),
            ],
          ),
        ),
        htmlEditor(simacontroller, simaJson),
        Row(
          children: [
            button("Előző", 1),
            button("Következő", 35, extra: () {
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
                "Teendők - 3/4",
                style: Theme.of(context).textTheme.headline4,
              ),
              const Text(
                'Most jön a móka. Meg kell csinálnod a dugi "about me"/aranyköpések '
                '(aranyköpéseknek van nevezve, mert nem volt jobb ötletem) '
                "részedet",
              ),
              const Text(
                  'Ide fog kerülni minden, de tényleg minden amit akarsz, szóval a képek, videók jöjjenek \n'),
              InkWell(
                onTap: () {
                  viccescontroller.reloadWeb();
                },
                child: const Text(
                    "Ha furán viselkedne a szerkesztő nyomj erre! (ilyenkor eltünik minden változás)"),
              ),
              const Text(
                  "Lehet más szerkeztővel jobban jársz. Mindegy igazából miaz csak egy html fájl jöjjön ki belőle"),
            ],
          ),
        ),
        htmlEditor(viccescontroller, viccesJson),
        Row(
          children: [
            button("Előző", 35, extra: () {
              simacontroller.reloadWeb();
            }),
            button("Következő", 4, extra: () {}),
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
                "Teendők - 4/4",
                style: Theme.of(context).textTheme.headline4,
              ),
              const Text(
                'Végesztél is a nehezével! Már csak le kell töltened a fájlt és elküldeni nekem vagy az osztálycsoportba',
              ),
            ],
          ),
        ),
        downloadbutton(viccesJson, simaJson),
        button("Előző", 3, extra: () {
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
      child: const Text("Letöltés"),
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
      child: const Text("Profilkép feltöltése"),
    );
  }

  Widget uploadedImage(String img) {
    if (img != "" || img != "/among-us.gif") {
      var decodedimg =
          base64Decode(img.replaceAll("data:image/png;base64, ", ""));
      return Image.memory(decodedimg);
    } else {
      return const Text("Még nincs kép feltöltve");
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
