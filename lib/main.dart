import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jurnal/Skip.dart';
import 'package:jurnal/TimeT.dart';
import 'package:jurnal/User.dart';
import 'package:jurnal/db_skip.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:table_calendar/table_calendar.dart';
import 'db_helper.dart';
import 'db_para.dart';

void main() {
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

String focus = "";
String dayName = "";
double x_ = 0; //= MediaQuery.sizeOf(context).width;
double y_ = 0; //= MediaQuery.sizeOf(context).height;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    x_ = MediaQuery.sizeOf(context).width;
    y_ = MediaQuery.sizeOf(context).height;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', x: x_, y: y_),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final double x;
  final double y;
  const MyHomePage(
      {super.key, required this.title, required this.x, required this.y});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic _selectedDay;
  dynamic _focusedDay;

  String dropdownvalue = 'Календарь';
  List<Widget> re = [];
  List<Para> _users = [];
  DateFormat formatD = DateFormat("EEEE");
  DateFormat ddd = DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY);
  String sd = "";
  final DbPara data = DbPara();
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    List<Para> users = await data.getUsers();
    setState(() {
      _users = users;
    });
  }

  Container function(
      x, y, String nm, String gro_, String time_of, String name_s) {
    return Container(
      width: x,
      height: y * 0.3,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 33, 117, 243),
          borderRadius: BorderRadius.circular(5)),
      child: TextButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentList(
                            gro: gro_,
                            time_of: time_of,
                            nm: name_s,
                          )));
            });
          },
          child: Text(
            nm,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
    );
  }

  Future<void> _updateRe() async {
    setState(() {
      re.clear();
      for (int i = 0; i < _users.length; i++) {
        if (_users[i].dayOfWeek == "Понедельник" && "${focus}" == "Monday") {
          setState(() {
            re.add(function(
                widget.x * 0.1,
                widget.y,
                "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}",
                _users[i].group,
                sd,
                _users[i].name));
          });
        } else if (_users[i].dayOfWeek == "Вторник" &&
            "${focus}" == "Tuesday") {
          setState(() {
            re.add(function(
                widget.x * 0.1,
                widget.y,
                "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}",
                _users[i].group,
                sd,
                _users[i].name));
          });
        } else if (_users[i].dayOfWeek == "Среда" &&
            "${focus}" == "Wednesday") {
          setState(() {
            re.add(function(
                widget.x * 0.1,
                widget.y,
                "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}",
                _users[i].group,
                sd,
                _users[i].name));
          });
        } else if (_users[i].dayOfWeek == "Четверг" &&
            "${focus}" == "Thursday") {
          setState(() {
            re.add(function(
                widget.x * 0.1,
                widget.y,
                "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}",
                _users[i].group,
                sd,
                _users[i].name));
          });
        } else if (_users[i].dayOfWeek == "Пятница" && "${focus}" == "Friday") {
          setState(() {
            re.add(function(
                widget.x * 0.1,
                widget.y,
                "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}",
                _users[i].group,
                sd,
                _users[i].name));
          });
        } else if (_users[i].dayOfWeek == "Суббота" && "${focus}" == "Sunday") {
          setState(() {
            re.add(function(
                widget.x * 0.1,
                widget.y,
                "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}",
                _users[i].group,
                sd,
                _users[i].name));
          });
        }
      }
    });
  }

  var items = [
    'Календарь',
    'Расписание',
    'Список группы',
  ];

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.sizeOf(context).width;
    double y = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Журнал"),
        actions: [
          Column(
            children: [
              DropdownButton(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                      if (dropdownvalue == "Список группы") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Group(x: x, y: y)));
                        dropdownvalue = 'Календарь';
                      } else if (dropdownvalue == "Расписание") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TimeTableR()));
                        dropdownvalue = 'Календарь';
                      }
                    });
                  })
            ],
          )
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            headerStyle: HeaderStyle(formatButtonVisible: false),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                focus = formatD.format(selectedDay);
                sd = ddd.format(selectedDay);
                _updateRe();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
                itemCount: re.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: re[index],
                  );
                }),
          ),
          Text("${focus}\t${sd}")
        ],
      ),
    );
  }
}

class Group extends StatefulWidget {
  final double x;
  final double y;
  const Group({super.key, required this.x, required this.y});

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Widget> re = [];
  List<User> _users = [];
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    List<User> users = await _dbHelper.getUsers();
    setState(() {
      _users = users;
    });
    _updateRe();
  }

  Future<void> _updateRe() async {
    re.clear();
    setState(() {
      for (int i = 0; i < _users.length; i++) {
        re.add(Container(
          height: widget.x * 0.1,
          width: widget.y,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${_users[i].id}\t${_users[i].username}\t${_users[i].group}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ));
      }
    });
  }

  Future<void> _addUser() async {
    re.clear();
    if (_usernameController.text.isNotEmpty &&
        _groupController.text.isNotEmpty) {
      User newUser = User(
          username: _usernameController.text, group: _groupController.text);
      await _dbHelper.insertUser(newUser);
      _usernameController.clear();
      _groupController.clear();
      await _loadUsers();
      _updateRe();
    }
  }

  Future<void> _del() async {
    for (int i = 0; i < _users.length; i++) {
      await _dbHelper.deleteUser(_users[i].id as int);
    }
    _updateRe();
  }

  String dropdownvalue = 'Первая';
  var items = ['Первая', 'Вторая'];

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.sizeOf(context).width;
    double y = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Назад',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: re.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: re[index],
                  );
                }),
          ),
          Expanded(
            child: SizedBox(
              height: y * 0.2,
              child: Column(
                children: [
                  TextField(
                    decoration:
                        const InputDecoration(hintText: "Введите имя студента"),
                    controller: _usernameController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text("Выберите группу"),
                      SizedBox(
                        width: 5,
                      ),
                      DropdownButton(
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              if (dropdownvalue == "Первая") {
                                _groupController.text = "Первая";
                                dropdownvalue = 'Первая';
                              } else if (dropdownvalue == "Вторая") {
                                _groupController.text = "Вторая";
                                dropdownvalue = 'Вторая';
                              }
                            });
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: x * 0.49,
                  height: y * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          _addUser();
                        });
                      },
                      child: const Text(
                        "Добавить",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  width: x * 0.49,
                  height: y * 0.1,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 243, 33, 33),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          _del();
                        });
                      },
                      child: const Text(
                        "Удалить всех",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TimeTableR extends StatefulWidget {
  const TimeTableR({super.key});

  @override
  State<TimeTableR> createState() => _TimeTableRState();
}

class _TimeTableRState extends State<TimeTableR> {
  final DbPara _dbHelper = DbPara();
  List<Para> _users = [];
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    List<Para> users = await _dbHelper.getUsers();
    setState(() {
      _users = users;
    });
  }

  Future<void> _del() async {
    for (int i = 0; i < _users.length; i++) {
      await _dbHelper.deleteUser(_users[i].id as int);
    }
  }

  Container function(x, y, String nm) {
    return Container(
      width: x,
      height: y * 0.1,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 33, 117, 243),
          borderRadius: BorderRadius.circular(5)),
      child: TextButton(
          onPressed: () {
            setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsDay(to: nm)));
            });
          },
          child: Text(
            nm,
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.sizeOf(context).width;
    double y = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Назад',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        body: ListView(
          children: [
            Container(
              width: x,
              height: y * 0.1,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 33, 33),
                  borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      _del();
                    });
                  },
                  child: const Text(
                    "Удалить расписание",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            function(x, y, "Понедельник"),
            const SizedBox(
              height: 5,
            ),
            function(x, y, "Вторник"),
            const SizedBox(
              height: 5,
            ),
            function(x, y, "Среда"),
            const SizedBox(
              height: 5,
            ),
            function(x, y, "Четверг"),
            const SizedBox(
              height: 5,
            ),
            function(x, y, "Пятница"),
            const SizedBox(
              height: 5,
            ),
            function(x, y, "Суббота"),
          ],
        ));
  }
}

class SettingsDay extends StatefulWidget {
  final String to;
  const SettingsDay({super.key, required this.to});

  @override
  State<SettingsDay> createState() => _SettingsDayState();
}

class _SettingsDayState extends State<SettingsDay> {
  Container TMsettings(x, y, String day, String timeOf) {
    return Container(
      width: x,
      height: y * 0.1,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 33, 117, 243),
          borderRadius: BorderRadius.circular(5)),
      child: TextButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimeSetings(
                      tm: timeOf,
                      day: day,
                    ),
                  ));
            });
          },
          child: Text(
            timeOf,
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.sizeOf(context).width;
    double y = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.to}',
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Column(
        children: [
          TMsettings(x, y, widget.to, "8.30-10.05"),
          const SizedBox(
            height: 5,
          ),
          TMsettings(x, y, widget.to, "10.20-11.55"),
          const SizedBox(
            height: 5,
          ),
          TMsettings(x, y, widget.to, "12.10-13.45"),
          const SizedBox(
            height: 5,
          ),
          TMsettings(x, y, widget.to, "14.15-15.50"),
        ],
      ),
    );
  }
}

class TimeSetings extends StatefulWidget {
  final String tm;
  final String day;
  const TimeSetings({super.key, required this.tm, required this.day});

  @override
  State<TimeSetings> createState() => _TimeSetingsState();
}

class _TimeSetingsState extends State<TimeSetings> {
  final TextEditingController _groupControl = TextEditingController();
  final TextEditingController _paraNameControl = TextEditingController();
  final TextEditingController _audit = TextEditingController();
  String dropdownvalue = 'Первая';
  var items = ['Первая', 'Вторая', 'Общая'];
  final DbPara _dbPara = DbPara();
  void _addPara() async {
    if (_groupControl.text.isNotEmpty &&
        _paraNameControl.text.isNotEmpty &&
        _audit.text.isNotEmpty) {
      Para newPara = Para(
          name: _paraNameControl.text,
          audit: _audit.text,
          group: _groupControl.text,
          dayOfWeek: widget.day,
          Time: widget.tm);
      await _dbPara.insertUser(newPara);
      _groupControl.clear();
      _paraNameControl.clear();
      _audit.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.tm}\t${widget.day}"),
      ),
      body: Column(
        children: [
          TextField(
            decoration:
                const InputDecoration(hintText: "Введите название пары"),
            controller: _paraNameControl,
          ),
          TextField(
            decoration: const InputDecoration(hintText: "Аудитория"),
            controller: _audit,
          ),
          Row(
            children: [
              Text("Выберите подгруппу на паре"),
              SizedBox(
                width: 5,
              ),
              DropdownButton(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                      if (dropdownvalue == "Первая") {
                        _groupControl.text = "Первая";
                        dropdownvalue = 'Первая';
                      } else if (dropdownvalue == "Вторая") {
                        _groupControl.text = "Вторая";
                        dropdownvalue = 'Вторая';
                      } else if (dropdownvalue == "Общая") {
                        _groupControl.text = "Общая";
                        dropdownvalue = 'Общая';
                      }
                    });
                  }),
            ],
          ),
          Container(
            height: 50,
            width: 100,
            color: Colors.green,
            child: TextButton(
                onPressed: () {
                  _addPara();
                },
                child: const Text(
                  "Сохранить",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}

class StudentList extends StatefulWidget {
  final String gro;
  final String time_of;
  final String nm;
  const StudentList(
      {super.key, required this.gro, required this.time_of, required this.nm});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final DbSkip _dbSkip = DbSkip();
  List<User> _users = [];
  Color _defaultColor = Color.fromARGB(255, 33, 117, 243);
  List<Color> _buttonColors = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    List<User> users = await _dbHelper.getUsers();
    setState(() {
      _users = users;
      _buttonColors = List<Color>.filled(users.length, _defaultColor);
    });
  }

  Future<void> addSkip(int i) async {
    Skip sk = Skip(
        time_of: widget.time_of, nm: "${_users[i].username}\t${widget.nm}");
    await _dbSkip.insertUser(sk);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Назад"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                if ((widget.gro == "Первая" &&
                        _users[index].group == "Первая") ||
                    (widget.gro == "Вторая" &&
                        _users[index].group == "Вторая") ||
                    (widget.gro == "Общая")) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _buttonColors[index],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _buttonColors[index] = Colors.red;
                            addSkip(index);
                          });
                        },
                        child: Text(
                          "${_users[index].username}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: _defaultColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Skiplist()),
                );
              },
              child: Text(
                "Перейти к пропускам",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Skiplist extends StatefulWidget {
  const Skiplist({super.key});

  @override
  State<Skiplist> createState() => _SkiplistState();
}

class _SkiplistState extends State<Skiplist> {
  List<Widget> re = [];
  final DbSkip _dbSkip = DbSkip();
  List<Skip> _skips = [];
  @override
  void initState() {
    super.initState();
    _loadSkips();
  }

  Future<void> _loadSkips() async {
    List<Skip> skips = await _dbSkip.getUsers();
    setState(() {
      _skips = skips;
    });
    _updateRe();
  }

  Future<void> _updateRe() async {
    for (int i = 0; i < _skips.length; i++) {
      re.add(Container(
        width: x_,
        height: y_ * 0.1,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(5)),
        child: TextButton(
            onPressed: () {
              setState(() {});
            },
            child: Text(
              "${_skips[i].nm}\t${_skips[i].time_of}",
              style: TextStyle(color: Colors.white),
            )),
      ));
    }
  }

  Future<void> _removeAllSkips() async {
    for (int i = 0; i < _skips.length; i++) {
      await _dbSkip.deleteUser(_skips[i].id as int);
    }
    setState(() {
      re.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Назад"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: re.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: re[index],
                  );
                }),
          ),
          Container(
            width: x_,
            height: y_ * 0.1,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(5)),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    _removeAllSkips();
                  });
                },
                child: Text(
                  "Удалить все пропуски",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
