class SystemRequirements  {
  final String os;
  final String processor;
  final String memory;
  final String graphics;
  final String storage;

  const SystemRequirements({
    required this.os,
    required this.processor,
    required this.memory,
    required this.graphics,
    required this.storage,
  });

  static defaultRequirement() {
    return const SystemRequirements(
      os: "Windows 7 64-Bit (SP1) or Windows 10 64-Bit",
      processor: "Intel Core i3-4340 or AMD FX-4300",
      memory: "2GB RAM",
      graphics: "Intel UHD Graphics 600",
      storage: "HDD",
    );
  }
}
