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
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
    _week.text = 'Числитель';
  }

  Future<void> _loadUsers() async {
    List<Para> users = await data.getUsers();
    setState(() {
      _users = users;
    });
  }

  Container function(
      x, y, String nm, String gro_, String time_of, String name_s, String tp) {
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
                            type: tp,
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

  String dropwalue = 'Числитель';
  var items_ = ['Числитель', 'Знаменатель'];
  final TextEditingController _week = TextEditingController();

  Future<void> _updateRe() async {
    setState(() {
      re.clear();
      for (int i = 0; i < _users.length; i++) {
        if (_week.text == 'Числитель' && _users[i].week == 'Числитель') {
          if (_users[i].dayOfWeek == "Понедельник" && "${focus}" == "Monday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Вторник" &&
              "${focus}" == "Tuesday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Среда" &&
              "${focus}" == "Wednesday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Четверг" &&
              "${focus}" == "Thursday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Пятница" &&
              "${focus}" == "Friday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Суббота" &&
              "${focus}" == "Sunday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          }
        } else if (_week.text == 'Знаменатель' &&
            _users[i].week == 'Знаменатель') {
          if (_users[i].dayOfWeek == "Понедельник" && "${focus}" == "Monday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Вторник" &&
              "${focus}" == "Tuesday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Среда" &&
              "${focus}" == "Wednesday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Четверг" &&
              "${focus}" == "Thursday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Пятница" &&
              "${focus}" == "Friday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Суббота" &&
              "${focus}" == "Sunday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          }
        } else if (_users[i].week == 'Инста') {
          if (_users[i].dayOfWeek == "Понедельник" && "${focus}" == "Monday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Вторник" &&
              "${focus}" == "Tuesday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Среда" &&
              "${focus}" == "Wednesday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Четверг" &&
              "${focus}" == "Thursday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Пятница" &&
              "${focus}" == "Friday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          } else if (_users[i].dayOfWeek == "Суббота" &&
              "${focus}" == "Sunday") {
            setState(() {
              re.add(function(
                  widget.x * 0.1,
                  widget.y,
                  "Время ${_users[i].Time}\nИмя ${_users[i].name}\nГруппа ${_users[i].group}\nАудитория ${_users[i].audit}\nТип: ${_users[i].type}",
                  _users[i].group,
                  sd,
                  _users[i].name,
                  _users[i].type));
            });
          }
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
          Column(
            children: [
              Text("Выберите числитель или знаменатель"),
              SizedBox(
                width: 5,
              ),
              DropdownButton(
                  value: dropwalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items_.map((String items_) {
                    return DropdownMenuItem(
                      value: items_,
                      child: Text(items_),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropwalue = newValue!;
                      if (dropwalue == "Числитель") {
                        _week.text = "Числитель";
                        dropwalue = 'Числитель';
                      } else if (dropwalue == "Знаменатель") {
                        _week.text = "Знаменатель";
                        dropwalue = 'Знаменатель';
                      }
                    });
                  }),
            ],
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
          Text("${sd}")
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

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Подтверждение"),
          content: Text("Вы уверены, что хотите продолжить?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Нет"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _del();
              },
              child: Text("Да"),
            ),
          ],
        );
      },
    );
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
                      onPressed: _showConfirmationDialog,
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

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Подтверждение"),
          content: Text("Вы уверены, что хотите продолжить?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Нет"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _del();
              },
              child: Text("Да"),
            ),
          ],
        );
      },
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
                  onPressed: _showConfirmationDialog,
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
  final TextEditingController _week = TextEditingController();
  final TextEditingController _type = TextEditingController();
  String dropdownvalue = 'Первая';
  String dropwalue = 'Числитель';
  String dr = 'Семинар';
  var items_ = ['Числитель', 'Знаменатель', 'Инста'];
  var items = ['Первая', 'Вторая', 'Общая'];
  var it = ['Семинар', 'Лекция', 'Лаба'];
  final DbPara _dbPara = DbPara();
  @override
  void initState() {
    super.initState();
    _week.text = 'Числитель';
    _groupControl.text = "Первая";
    _type.text = 'Семинар';
  }

  void _addPara() async {
    if (_groupControl.text.isNotEmpty &&
        _paraNameControl.text.isNotEmpty &&
        _audit.text.isNotEmpty &&
        _week.text.isNotEmpty &&
        _type.text.isNotEmpty) {
      Para newPara = Para(
          name: _paraNameControl.text,
          audit: _audit.text,
          group: _groupControl.text,
          dayOfWeek: widget.day,
          Time: widget.tm,
          week: _week.text,
          type: _type.text);
      await _dbPara.insertUser(newPara);
      _week.clear();
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
          Column(
            children: [
              Text("Выберите тип"),
              SizedBox(
                width: 5,
              ),
              DropdownButton(
                  value: dr,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: it.map((String it) {
                    return DropdownMenuItem(
                      value: it,
                      child: Text(it),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dr = newValue!;
                      if (dr == "Семинар") {
                        _type.text = "Семинар";
                        dr = 'Семинар';
                      } else if (dr == "Лекция") {
                        _type.text = "Лекция";
                        dr = 'Лекция';
                      } else if (dr == "Лаба") {
                        _type.text = "Лаба";
                        dr = 'Лаба';
                      }
                    });
                  }),
              SizedBox(
                width: 5,
              ),
              Text("Выберите числитель или знаменатель"),
              SizedBox(
                width: 5,
              ),
              DropdownButton(
                  value: dropwalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items_.map((String items_) {
                    return DropdownMenuItem(
                      value: items_,
                      child: Text(items_),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropwalue = newValue!;
                      if (dropwalue == "Числитель") {
                        _week.text = "Числитель";
                        dropwalue = 'Числитель';
                      } else if (dropwalue == "Знаменатель") {
                        _week.text = "Знаменатель";
                        dropwalue = 'Знаменатель';
                      } else if (dropwalue == "Инста") {
                        _week.text = "Инста";
                        dropwalue = 'Инста';
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
  final String type;
  const StudentList(
      {super.key,
      required this.gro,
      required this.time_of,
      required this.nm,
      required this.type});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final DbSkip _dbSkip = DbSkip();
  List<User> _users = [];
  Color _defaultColor = Color.fromARGB(255, 33, 117, 243);
  List<Color> _buttonColors = [];
  List<Skip> _skips = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _loadSkips();
  }

  Future<void> _loadSkips() async {
    List<Skip> skips = await _dbSkip.getUsers();
    setState(() {
      _skips = skips;
    });
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
        time_of: widget.time_of,
        nm: "${_users[i].username}\t${widget.nm}",
        type: widget.type);
    await _dbSkip.insertUser(sk);
    _loadSkips();
  }

  Future<void> removeSkip(int index) async {
    await _dbSkip.deleteUser(
        _skips[index].id as int); 
    _loadSkips();
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
                        onLongPress: () {
                          setState(() {
                            _buttonColors[index] = _defaultColor; 
                            removeSkip(index); 
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
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<User> _users = [];
  final DbSkip _dbSkip = DbSkip();
  List<Skip> _skips = [];
  @override
  void initState() {
    super.initState();
    _loadSkips();
  }

  Future<void> _loadSkips() async {
    List<Skip> skips = await _dbSkip.getUsers();
    List<User> users = await _dbHelper.getUsers();
    setState(() {
      _skips = skips;
      _users = users;
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
              "${_skips[i].id} ${_skips[i].nm}\t${_skips[i].time_of}",
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

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Подтверждение"),
          content: Text("Вы уверены, что хотите продолжить?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Нет"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _removeAllSkips();
              },
              child: Text("Да"),
            ),
          ],
        );
      },
    );
  }

  void _showPath(String pth) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Сохранено"),
          content: Text(pth),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ок"),
            ),
          ],
        );
      },
    );
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }
  Future<String> getStoragePath() async {
    final directory = await getExternalStorageDirectory();
    return directory?.path ?? '';
  }
  void createExcelFile() async {
    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];
    sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue("ФИО");
    sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue("Лекции");
    sheet.cell(CellIndex.indexByString('C1')).value = TextCellValue("Лабы");
    sheet.cell(CellIndex.indexByString('D1')).value = TextCellValue("Семы");
    for (int i = 0; i < _users.length; i++) {
      sheet.cell(CellIndex.indexByString("A${i + 2}")).value =
          TextCellValue(_users[i].username);
    }

    for (int i = 0; i < _users.length; i++) {
      int lection_skip = 0;
      int sem = 0;
      int lab = 0;
      for (int j = 0; j < _skips.length; j++) {
        if (_users[i].username == _skips[j].nm.split('\t')[0] &&
            _skips[j].type == 'Семинар') {
          sem = sem + 1;
        } else if (_users[i].username == _skips[j].nm.split('\t')[0] &&
            _skips[j].type == 'Лекция') {
          lection_skip = lection_skip + 1;
        } else if (_users[i].username == _skips[j].nm.split('\t')[0] &&
            _skips[j].type == 'Лаба') {
          lab = lab + 1;
        }
      }
      sheet.cell(CellIndex.indexByString('B${i + 2}')).value =
          TextCellValue(lection_skip.toString());
      sheet.cell(CellIndex.indexByString('C${i + 2}')).value =
          TextCellValue(sem.toString());
      sheet.cell(CellIndex.indexByString('D${i + 2}')).value =
          TextCellValue(lab.toString());
    }
    await requestStoragePermission();

    String storagePath = await getStoragePath();
    String filePath = "$storagePath/gr.xlsx";

    var file = File(filePath);
    List<int>? fileBytes = excel.save();
    await file.writeAsBytes(fileBytes!);
    _showPath("${file}");
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
          Row(
            children: [
              Container(
                width: x_ * 0.49,
                height: y_ * 0.1,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                    onPressed: _showConfirmationDialog,
                    child: Text(
                      "Удалить все пропуски",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                width: x_ * 0.02,
              ),
              Container(
                width: x_ * 0.49,
                height: y_ * 0.1,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                    onPressed: createExcelFile,
                    child: Text(
                      "Экспорт в excel",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
