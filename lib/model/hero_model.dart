class HeroModel {
  late int id;
  late String name;
  late String localizedName;
  late String primaryAttr;
  late String attackType;
  List<String>? roles;
  late String img;
  String? icon;
  late double baseHealth;
  double? baseHealthRegen;
  late double baseMana;
  double? baseManaRegen;
  double? baseArmor;
  double? baseMr;
  late double baseAttackMin;
  late double baseAttackMax;
  double? baseStr;
  double? baseAgi;
  double? baseInt;
  double? strGain;
  double? agiGain;
  double? intGain;
  double? attackRange;
  double? projectileSpeed;
  double? attackRate;
  late double moveSpeed;
  double? turnRate;
  bool? cmEnabled;
  int? legs;
  int? heroId;
  int? turboPicks;
  int? turboWins;
  int? proWin;
  int? proPick;
  int? proBan;
  int? i1Pick;
  int? i1Win;
  int? i2Pick;
  int? i2Win;
  int? i3Pick;
  int? i3Win;
  int? i4Pick;
  int? i4Win;
  int? i5Pick;
  int? i5Win;
  int? i6Pick;
  int? i6Win;
  int? i7Pick;
  int? i7Win;
  int? i8Pick;
  int? i8Win;
  int? nullPick;
  int? nullWin;

  HeroModel(
      {required this.id,
        required this.name,
        required this.localizedName,
        required this.primaryAttr,
        required this.attackType,
        this.roles,
        required this.img,
        this.icon,
        required this.baseHealth,
        this.baseHealthRegen,
        required this.baseMana,
        this.baseManaRegen,
        this.baseArmor,
        this.baseMr,
        required this.baseAttackMin,
        required this.baseAttackMax,
        this.baseStr,
        this.baseAgi,
        this.baseInt,
        this.strGain,
        this.agiGain,
        this.intGain,
        this.attackRange,
        this.projectileSpeed,
        this.attackRate,
        required this.moveSpeed,
        this.turnRate,
        this.cmEnabled,
        this.legs,
        this.heroId,
        this.turboPicks,
        this.turboWins,
        this.proWin,
        this.proPick,
        this.proBan,
        this.i1Pick,
        this.i1Win,
        this.i2Pick,
        this.i2Win,
        this.i3Pick,
        this.i3Win,
        this.i4Pick,
        this.i4Win,
        this.i5Pick,
        this.i5Win,
        this.i6Pick,
        this.i6Win,
        this.i7Pick,
        this.i7Win,
        this.i8Pick,
        this.i8Win,
        this.nullPick,
        this.nullWin});

  HeroModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    localizedName = json['localized_name'];
    primaryAttr = json['primary_attr'];
    attackType = json['attack_type'];
    roles = json['roles'].cast<String>();
    img = json['img'];
    icon = json['icon'];
    baseHealth = json['base_health'].toDouble();
    baseHealthRegen = json['base_health_regen'].toDouble();
    baseMana = json['base_mana'].toDouble();
    baseManaRegen = json['base_mana_regen'].toDouble();
    baseArmor = json['base_armor'].toDouble();
    baseMr = json['base_mr'].toDouble();
    baseAttackMin = json['base_attack_min'].toDouble();
    baseAttackMax = json['base_attack_max'].toDouble();
    baseStr = json['base_str'].toDouble();
    baseAgi = json['base_agi'].toDouble();
    baseInt = json['base_int'].toDouble();
    strGain = json['str_gain'].toDouble();
    agiGain = json['agi_gain'].toDouble();
    intGain = json['int_gain'].toDouble();
    attackRange = json['attack_range'].toDouble();
    projectileSpeed = json['projectile_speed'].toDouble();
    attackRate = json['attack_rate'].toDouble();
    moveSpeed = json['move_speed'].toDouble();
    //turnRate = json['turn_rate'].toDouble();
    cmEnabled = json['cm_enabled'];
    legs = json['legs'];
    heroId = json['hero_id'];
    turboPicks = json['turbo_picks'];
    turboWins = json['turbo_wins'];
    proWin = json['pro_win'];
    proPick = json['pro_pick'];
    proBan = json['pro_ban'];
    i1Pick = json['1_pick'];
    i1Win = json['1_win'];
    i2Pick = json['2_pick'];
    i2Win = json['2_win'];
    i3Pick = json['3_pick'];
    i3Win = json['3_win'];
    i4Pick = json['4_pick'];
    i4Win = json['4_win'];
    i5Pick = json['5_pick'];
    i5Win = json['5_win'];
    i6Pick = json['6_pick'];
    i6Win = json['6_win'];
    i7Pick = json['7_pick'];
    i7Win = json['7_win'];
    i8Pick = json['8_pick'];
    i8Win = json['8_win'];
    nullPick = json['null_pick'];
    nullWin = json['null_win'];
  }

}
