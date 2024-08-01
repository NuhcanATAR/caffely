enum StepProccess {
  oneView, // 0
  secondView, // 1
  threeView, // 2
}

extension StepProccessControlExtension on StepProccess {
  int get value {
    switch (this) {
      case StepProccess.oneView:
        return 0;
      case StepProccess.secondView:
        return 1;
      case StepProccess.threeView:
        return 2;
    }
  }
}
