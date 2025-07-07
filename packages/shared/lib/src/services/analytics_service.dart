/// Analytics service interface for tracking user events and behavior
abstract class AnalyticsService {
  /// Initialize analytics service
  Future<void> initialize();

  /// Track a custom event
  Future<void> trackEvent(String name, {Map<String, dynamic>? parameters});

  /// Track screen view
  Future<void> trackScreenView(
    String screenName, {
    Map<String, dynamic>? parameters,
  });

  /// Track user login
  Future<void> trackLogin(String method);

  /// Track user signup
  Future<void> trackSignup(String method);

  /// Track purchase
  Future<void> trackPurchase(
    double value,
    String currency, {
    Map<String, dynamic>? parameters,
  });

  /// Set user property
  Future<void> setUserProperty(String name, String value);

  /// Set user ID
  Future<void> setUserId(String userId);

  /// Reset user data
  Future<void> resetUser();

  /// Enable/disable analytics tracking
  Future<void> setAnalyticsEnabled(bool enabled);
}

/// Analytics event model
class AnalyticsEvent {
  AnalyticsEvent({
    required this.name,
    this.parameters = const {},
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  final String name;
  final Map<String, dynamic> parameters;
  final DateTime timestamp;

  Map<String, dynamic> toMap() => {
    'name': name,
    'parameters': parameters,
    'timestamp': timestamp.millisecondsSinceEpoch,
  };
}

/// Mock analytics service for testing
class MockAnalyticsService implements AnalyticsService {
  final List<AnalyticsEvent> _events = [];
  final Map<String, String> _userProperties = {};
  String? _userId;
  bool _isEnabled = true;

  List<AnalyticsEvent> get events => List.unmodifiable(_events);
  Map<String, String> get userProperties => Map.unmodifiable(_userProperties);
  String? get userId => _userId;
  bool get isEnabled => _isEnabled;

  void clearEvents() => _events.clear();

  @override
  Future<void> initialize() async {
    // Mock initialization
  }

  @override
  Future<void> trackEvent(
    String name, {
    Map<String, dynamic>? parameters,
  }) async {
    if (!_isEnabled) return;

    _events.add(AnalyticsEvent(name: name, parameters: parameters ?? {}));
  }

  @override
  Future<void> trackScreenView(
    String screenName, {
    Map<String, dynamic>? parameters,
  }) async {
    await trackEvent(
      'screen_view',
      parameters: {'screen_name': screenName, ...?parameters},
    );
  }

  @override
  Future<void> trackLogin(String method) async {
    await trackEvent('login', parameters: {'method': method});
  }

  @override
  Future<void> trackSignup(String method) async {
    await trackEvent('signup', parameters: {'method': method});
  }

  @override
  Future<void> trackPurchase(
    double value,
    String currency, {
    Map<String, dynamic>? parameters,
  }) async {
    await trackEvent(
      'purchase',
      parameters: {'value': value, 'currency': currency, ...?parameters},
    );
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    if (!_isEnabled) return;
    _userProperties[name] = value;
  }

  @override
  Future<void> setUserId(String userId) async {
    if (!_isEnabled) return;
    _userId = userId;
  }

  @override
  Future<void> resetUser() async {
    _userId = null;
    _userProperties.clear();
  }

  @override
  Future<void> setAnalyticsEnabled(bool enabled) async {
    _isEnabled = enabled;
  }
}
