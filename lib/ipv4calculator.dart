import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'IPv4 Subnet Calculator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController subnetController = TextEditingController();
  Subnet? selectedSubnet;
  final TextEditingController _ip = TextEditingController();

  var text = '';

  var table = false;
  var netadd = '';
  var uhr = '';
  var sub = '';
  var cidr = '';
  var ipran = '';
  var bro = '';
  var cla = '';
  var bsub = '';
  var wil = '';
  int tnhost = 0;
  int ushost = 0;
  String type = 'Public';

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<Subnet>> subnetEntries =
        <DropdownMenuEntry<Subnet>>[];
    for (final Subnet subnet in Subnet.values) {
      subnetEntries.add(
        DropdownMenuEntry<Subnet>(value: subnet, label: subnet.label),
      );
    }

    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
//         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
//           const Text('Network Class: '),
//           Radio(
//             value: Class.A,
//             groupValue: _char,
//             onChanged: (Class? value) {
//               setState(() {
//                 _char = value;
//               });
//             },
//           ),
//           const Text('A'),
//           Radio(
//             value: Class.B,
//             groupValue: _char,
//             onChanged: (Class? value) {
//               setState(() {
//                 _char = value;
//               });
//             },
//           ),
//           const Text('B'),
//           Radio(
//             value: Class.C,
//             groupValue: _char,
//             onChanged: (Class? value) {
//               setState(() {
//                 _char = value;
//               });
//             },
//           ),
//           const Text('C'),
//         ]),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownMenu<Subnet>(
                width: 250,
                initialSelection: Subnet.a,
                controller: subnetController,
                label: const Text('subnet'),
                dropdownMenuEntries: subnetEntries,
                onSelected: (Subnet? subnet) {
                  setState(() {
                    selectedSubnet = subnet;
                  });
                },
              ),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          SizedBox(
            width: 250,
            child: TextField(
              controller: _ip,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "IP Address",
              ),
            ),
          ),
        ]),
        const SizedBox(height: 20),
        ElevatedButton(
          style: style,
          onPressed: () {
            final ip = _ip.text;
            var vip = 0;
            var bsubarr = [];
            var naddarr = [];
            final splitted = ip.split('.');
            sub = selectedSubnet == null
                ? '255.255.255.0'
                : (selectedSubnet?.label).toString();
            cidr = selectedSubnet == null
                ? '/24'
                : (selectedSubnet?.cidr).toString();
            cla =
                selectedSubnet == null ? 'C' : (selectedSubnet?.cla).toString();
            final splittedsub = sub.split('.');
            for (var i = 0; i < splittedsub.length; i++) {
              (int.parse(splittedsub[i]) == 0)
                  ? bsubarr.add('00000000')
                  : bsubarr.add(
                      int.parse(splittedsub[i]).toRadixString(2).toString());
            }
            bsub = bsubarr.join(".");
            for (var i = 0; i < splitted.length; i++) {
              if (int.parse(splitted[i]) <= 255 &&
                  int.parse(splitted[i]) >= 0) {
                vip++;
              }
            }
            if ((splitted[0] == '192' && splitted[1] == '168') ||
                ip == '127.0.0.1') {
              type = 'Private';
            } else {
              type = 'Public';
            }
            setState(() {
              if (vip == 4) {
                text = ip;
                table = true;
                switch (cla) {
                  case 'C':
                    var ips3 = int.parse(splittedsub[3]) + 1;
                    var ipe3 = splittedsub[3] == 0
                        ? 0
                        : 255 - int.parse(splittedsub[3]);
                    splitted.removeAt(3);
                    var add = splitted.join('.');
                    netadd = add + '.' + ipe3.toString();
                    var ips = add + '.' + ips3.toString();
                    var ipe = add + ".254";
                    ipran = ips + " - " + ipe;
                    bro = add + '.' + ipe3.toString();
                    wil = '0.0.0.' + '.' + ipe3.toString();
                    tnhost = ipe3 + 1;
                    ushost = ipe3 - 1;
                    break;
                  case 'B':
                    var ips2 = splittedsub[2] == 0
                        ? 0
                        : 255 - int.parse(splittedsub[2]) + 1;
                    var ipe2 = splittedsub[2] == 0
                        ? 0
                        : 255 - int.parse(splittedsub[2]);
                    splitted.removeAt(3);
                    var add = splitted.join('.');
                    netadd = add + '.0';
                    var ips = add + '.1';
                    var ipe = splitted[0] +
                        '.' +
                        splitted[1] +
                        '.' +
                        (ips2 + ipe2).toString() +
                        ".254";
                    ipran = ips + " - " + ipe;
                    bro = splitted[0] +
                        '.' +
                        splitted[1] +
                        '.' +
                        ipe2.toString() +
                        '.255';
                    wil = '0.0.' + ipe2.toString() + '.255';
                    tnhost = ips2 * 256;
                    ushost = ips2 * 256 - 2;
                    break;
                  case 'A':
                    var ips1 = splittedsub[1] == 0
                        ? 0
                        : 255 - int.parse(splittedsub[1]) + 1;
                    var ipe1 = splittedsub[1] == 0
                        ? 0
                        : 255 - int.parse(splittedsub[1]);
                    splitted.removeAt(3);
                    splitted.removeAt(2);
                    var add = splitted.join('.');
                    netadd = add + '.0.0';
                    var ips = add + '.0.1';
                    var ipe = splitted[0] + '.' + ipe1.toString() + ".255.254";
                    ipran = ips + " - " + ipe;
                    bro = splitted[0] + '.' + ipe1.toString() + ".255.255";
                    wil = '0.' + ipe1.toString() + '.255.255';
                    tnhost = ips1 * 256 * 256;
                    ushost = ips1 * 256 * 256 - 2;
                    break;
                }
              } else {
                table = false;
                text = 'ip invalid';
              }
            });
          },
          child: const Text('Calculate'),
        ),
        const SizedBox(height: 20),
        SizedBox(
            child: table
                ? tablea('$text', '$sub', '$cidr', '$cla', '$bsub', '$netadd',
                    '$wil', '$ipran', '$bro', '$tnhost', '$ushost', '$type')
                : Text('$text', style: const TextStyle(fontSize: 25))),
      ],
    );
  }
}

Table tablea(
    text, sub, cidr, cla, bsub, netadd, wil, ipran, bro, tnhost, ushost, type) {
  return Table(
    children: [
      TableRow(children: [
        Text("IP Address:"),
        Text(text),
      ]),
      TableRow(children: [
        Text("Network Address:"),
        Text(netadd),
      ]),
      TableRow(children: [
        Text("Usable Host IP Range:"),
        Text(ipran),
      ]),
      TableRow(children: [
        Text("Broadcast Address:"),
        Text(bro),
      ]),
      TableRow(children: [
        Text("Total Number of Hosts:"),
        Text(tnhost),
      ]),
      TableRow(children: [
        Text("Number of Usable Hosts:"),
        Text(ushost),
      ]),
      TableRow(children: [
        Text("Subnet Mask:"),
        Text(sub),
      ]),
      TableRow(children: [
        Text("Wildcard Mask:"),
        Text(wil),
      ]),
      TableRow(children: [
        Text("Binary Subnet Mask:"),
        Text(bsub),
      ]),
      TableRow(children: [
        Text("IP Class:"),
        Text(cla),
      ]),
      TableRow(children: [
        Text("CIDR Notation:"),
        Text(cidr),
      ]),
      TableRow(children: [
        Text("IP Type:"),
        Text(type),
      ]),
    ],
  );
}

enum Subnet {
  a('255.255.255.0', '/24', 'C'),
  b('255.255.255.192', '/26', 'C'),
  c('255.255.255.252', '/30', 'C'),
  d('255.255.0.0', '/16', 'B'),
  e('255.255.192.0', '/18', 'B'),
  f('255.255.255.0', '/24', 'B'),
  g('255.0.0.0', '/8', 'A'),
  h('255.192.0.0', '/10', 'A');
  // i('255.255.255.192', '/26', 'A');

  const Subnet(this.label, this.cidr, this.cla);
  final String label;
  final String cla;
  final String cidr;
}
