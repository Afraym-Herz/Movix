class ApiEndpoints {
  ApiEndpoints._();

  // Base URL
  static const String baseUrl = 'https://tiktok-production-8435.up.railway.app';

  // ============== AUTH ENDPOINTS ==============
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  static const String logout = '/api/auth/logout';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String resetPassword = '/api/auth/reset-password';
  static const String refreshToken = '/api/auth/refresh';

  // ============== USER ENDPOINTS ==============
  static String deleteUser(String userId) => '/api/users/$userId';
  static String editUser(String userId) => '/api/users/$userId';

  // ============== POSTS ENDPOINTS ==============
  static const String uploadVideo = '/api/posts/upload';
  static String deletePost(String postId) => '/api/posts/$postId';

  // ============== ADMIN ENDPOINTS ==============
  static const String getPendingPosts = '/api/admin/pending-posts';
  static String approvePost(String postId) => '/api/admin/approve/$postId';
  static String rejectPost(String postId) => '/api/admin/reject/$postId';

  // ============== COMMENTS ENDPOINTS ==============
  static String getComments(String postId) => '/api/comments/$postId';
  static String addComment(String postId) => '/api/posts/$postId/comments';
  static String deleteComment(String commentId) => '/api/comments/$commentId';

  // ============== REPLIES ENDPOINTS ==============
  static String getReplies(String commentId) => '/api/replies/$commentId';
  static String addReply(String commentId) => '/api/replies/$commentId';
  static String deleteReply(String replyId) => '/api/replies/$replyId';

  // ============== LIKES ENDPOINTS ==============
  static String addLike(String postId) => '/api/likes/$postId';
  static String getLikesCount(String postId) => '/api/likes/$postId';

  // ============== FOLLOW ENDPOINTS ==============
  static String followUser(String userId) => '/api/follow/$userId';
  static String unfollowUser(String userId) => '/api/follow/$userId';
  static String getFollowers(String userId) => '/api/follow/followers/$userId';
  static String getFollowing(String userId) => '/api/follow/following/$userId';
}