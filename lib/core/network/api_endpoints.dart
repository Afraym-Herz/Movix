class ApiEndpoints {
  ApiEndpoints._();

  // Base URL (TMDB for movie data)
  static const String baseUrl = 'https://api.themoviedb.org/3';

  /// TMDB API key (v3) — required for movie endpoints. Get at themoviedb.org/settings/api.
  static const String apiReadAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYjc4NDI1OWY1NGI4MTJiMjE4MjkzZjdlMTljZmI1OCIsIm5iZiI6MTc3MDc1Nzc4MS41NjA5OTk5LCJzdWIiOiI2OThiOWU5NTM5ZTE5N2QwZjMxZTY2MjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.eK3t9F0o6HFHAk7jLWmzxIUHzrwAuWUX78y7wJD7asA';

  static const String apiKey = '1b784259f54b812b218293f7e19cfb58';

  /// Base URL for poster images (append poster_path from movie, e.g. /w500/path).
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';

  /// GET — Top rated movies. Query: api_key, language, page.
  static const String topRatedMovies = '/movie/top_rated';

  static const String popularMovies = '/movie/popular';

  static String trendingMovies = '/trending/movie/day';

  static const String nowPlayingMovies = '/movie/now_playing';

  static const String upComingMovies = '/movie/upcoming';
  
  static const String searchMovies = '/trending/movie/search';

  /// GET — Movie details by ID. Query: api_key, language.
  static String movieDetails(int movieId) => '/movie/$movieId';

  /// GET — Recommended movies. Query: api_key, language.
  static String movieVideos(int movieId) => '/movie/$movieId/videos';

  static String recommendationsMovies(int movieId) =>
      '/movie/$movieId/recommendations';

  static String discoverMovies(String sortBy) =>
      '/discover/movie?include_adult=false&sort_by=$sortBy.desc';

  // ============== TV Series ENDPOINTS ==============
  static const String tvSeriesAiringToday = 'tv/airing_today';

  static const String tvSeriesPopular = '/tv/popular';

  static const String tvSeriesTopRated = '/tv/top_rated';

  static const String tvSeriesOnTheAir = '/tv/on_the_air';

  static const String airingTodayTVSeries = '/tv/airing_today';

  static String tvSeriesDetails(int tvSeriesId) => '/tv/$tvSeriesId';

  static String discoverTVSeries(String sortBy) => '/discover/tv?include_adult=false&sort_by=$sortBy.desc' ;

  static String recommendationsTVSeries(int tvSeriesId) =>
      '/tv/$tvSeriesId/recommendations';

  static const String tvSeriesLatest = '/tv/latest';




  // ============== AUTHENTICATION ENDPOINTS ==============
  /// GET — Create new request token
  static const String requestToken = '/authentication/token/new';

  /// POST — Search for a movie. Query: api_key, query, page.
  static const String search = '/find/';

  /// POST — Validate request token with login
  static const String validateWithLogin =
      '/authentication/token/validate_with_login';

  /// POST — Create new session
  static const String createSession = '/authentication/session/new';

  /// DELETE — Delete session
  static const String deleteSession = '/authentication/session';

  // ============== AUTH ENDPOINTS ==============
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  static const String logout = '/api/auth/logout';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String resetPassword = '/api/auth/reset-password';
  static const String refreshToken = '/api/auth/refresh';
}
