enum Status {
  initial,
  loading,
  success,
  failure,
  empty,
  refreshing,
}

extension StatusEmoji on Status {
  String get emoji {
    switch (this) {
      case Status.initial:
        return '🍼'; // newborn state
      case Status.loading:
        return '⏳'; // loading in progress
      case Status.success:
        return '✅'; // operation successful
      case Status.failure:
        return '❌'; // operation failed
      case Status.empty:
        return '📭'; // no content
      case Status.refreshing:
        return '🔄'; // refreshing data
    }
  }

  String get label {
    return emoji;
  }
}
