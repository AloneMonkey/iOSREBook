@class SCChatLoader;
@class SCStoryLoader;
@class AVPlayer;
@class SCStories;
@class SCSnapLoader;
@class SCAppNotificationProvider;
@class User;
@class ManagerUnarchiver;

%hook Manager
+ (long long)context { %log; long long r = %orig; HBLogDebug(@" = %lld", r); return r; }
+ (id)profiledSelectorNames { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
+ (void)clearUnusedVideoURLsExcludingURLsFromSnaps:(id)arg1 andStories:(id)arg2 { %log; %orig; }
+ (void)_autoLoadStoriesWithOnLaunch:(_Bool)arg1 { %log; %orig; }
+ (void)updateFidelius:(id)arg1 { %log; %orig; }
+ (id)inspectJsonValidity:(id)arg1 { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
+ (id)shared { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
+ (_Bool)isInitialized { %log; _Bool r = %orig; HBLogDebug(@" = %d", r); return r; }
+ (void)sendReportWithParams:(id)arg1 endpoint:(id)arg2 successBlock:(id)arg3 failureBlock:(id)arg4 { %log; %orig; }
+ (void)reportSnapWithParameters:(id)arg1 successBlock:(id)arg2 failureBlock:(id)arg3 { %log; %orig; }
+ (void)fetchPreCacheDataForLocationWithParameters:(id)arg1 requestParser:(id)arg2 callbackQueue:(id)arg3 successBlock:(id)arg4 failureBlock:(id)arg5 { %log; %orig; }
+ (void)fetchDataForLocationWithParameters:(id)arg1 callbackQueue:(id)arg2 successBlock:(id)arg3 failureBlock:(id)arg4 { %log; %orig; }
+ (void)registerDeviceTokenWithParameters:(id)arg1 successBlock:(id)arg2 failureBlock:(id)arg3 { %log; %orig; }
+ (void)fetchDescriptionForSharedStoryIdWithParameters:(id)arg1 successBlock:(id)arg2 failureBlock:(id)arg3 { %log; %orig; }
+ (void)requestDeviceIDWithRetriesWithParameters:(id)arg1 successBlock:(id)arg2 failureBlock:(id)arg3 { %log; %orig; }
+ (void)flushEvents:(id)arg1 successBlock:(id)arg2 failureBlock:(id)arg3 { %log; %orig; }
+ (void)markViewedSnapsWithParameters:(id)arg1 successBlock:(id)arg2 failureBlock:(id)arg3 { %log; %orig; }
+ (void)fetchAllUpdatesWithParameters:(id)arg1 optionalParameters:(id)arg2 successBlock:(id)arg3 failureBlock:(id)arg4 { %log; %orig; }
- (NSObject<OS_dispatch_queue> *)spotlightIndexingQueue { %log; NSObject<OS_dispatch_queue> * r = %orig; HBLogDebug(@" = 0x%lx", (uintptr_t)r); return r; }
- (NSObject<OS_dispatch_queue> *)flushEventsQueue { %log; NSObject<OS_dispatch_queue> * r = %orig; HBLogDebug(@" = 0x%lx", (uintptr_t)r); return r; }
- (void)setSessionCount:(unsigned long long )sessionCount { %log; %orig; }
- (unsigned long long )sessionCount { %log; unsigned long long  r = %orig; HBLogDebug(@" = %llu", r); return r; }
- (void)setSeqno:(unsigned long long )seqno { %log; %orig; }
- (unsigned long long )seqno { %log; unsigned long long  r = %orig; HBLogDebug(@" = %llu", r); return r; }
- (void)setEnabledIAPCurrencies:(NSArray *)enabledIAPCurrencies { %log; %orig; }
- (NSArray *)enabledIAPCurrencies { %log; NSArray * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setPendingStoriesAfterQuickLogin:(_Bool )pendingStoriesAfterQuickLogin { %log; %orig; }
- (_Bool )pendingStoriesAfterQuickLogin { %log; _Bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)setPendingFriendsDependentsAfterQuickLogin:(_Bool )pendingFriendsDependentsAfterQuickLogin { %log; %orig; }
- (_Bool )pendingFriendsDependentsAfterQuickLogin { %log; _Bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)setPendingConversationsAfterQuickLogin:(_Bool )pendingConversationsAfterQuickLogin { %log; %orig; }
- (_Bool )pendingConversationsAfterQuickLogin { %log; _Bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)setPushNotificationDeviceToken:(NSData *)pushNotificationDeviceToken { %log; %orig; }
- (NSData *)pushNotificationDeviceToken { %log; NSData * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setFetchingAllUpdatesFromServer:(_Bool )fetchingAllUpdatesFromServer { %log; %orig; }
- (_Bool )fetchingAllUpdatesFromServer { %log; _Bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)setShouldRecordFirstStoryWhenLaunchApp:(_Bool )shouldRecordFirstStoryWhenLaunchApp { %log; %orig; }
- (_Bool )shouldRecordFirstStoryWhenLaunchApp { %log; _Bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)setShouldRecordFirstSnapWhenLaunchApp:(_Bool )shouldRecordFirstSnapWhenLaunchApp { %log; %orig; }
- (_Bool )shouldRecordFirstSnapWhenLaunchApp { %log; _Bool  r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)setReferenceDateForFeedTimestamps:(NSDate *)referenceDateForFeedTimestamps { %log; %orig; }
- (NSDate *)referenceDateForFeedTimestamps { %log; NSDate * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setCentralTimer:(NSTimer *)centralTimer { %log; %orig; }
- (NSTimer *)centralTimer { %log; NSTimer * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setChatLoader:(SCChatLoader *)chatLoader { %log; %orig; }
- (SCChatLoader *)chatLoader { %log; SCChatLoader * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setSnapLoader:(SCSnapLoader *)snapLoader { %log; %orig; }
- (SCSnapLoader *)snapLoader { %log; SCSnapLoader * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setStoryLoader:(SCStoryLoader *)storyLoader { %log; %orig; }
- (SCStoryLoader *)storyLoader { %log; SCStoryLoader * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setCentralPlayerB:(AVPlayer *)centralPlayerB { %log; %orig; }
- (AVPlayer *)centralPlayerB { %log; AVPlayer * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setCentralPlayerA:(AVPlayer *)centralPlayerA { %log; %orig; }
- (AVPlayer *)centralPlayerA { %log; AVPlayer * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setTimes:(NSMutableDictionary *)times { %log; %orig; }
- (NSMutableDictionary *)times { %log; NSMutableDictionary * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setStories:(SCStories *)stories { %log; %orig; }
- (SCStories *)stories { %log; SCStories * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setNotificationController:(SCAppNotificationProvider *)notificationController { %log; %orig; }
- (SCAppNotificationProvider *)notificationController { %log; SCAppNotificationProvider * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setUser:(User *)user { %log; %orig; }
- (User *)user { %log; User * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setSnapDataTimer:(NSTimer *)snapDataTimer { %log; %orig; }
- (NSTimer *)snapDataTimer { %log; NSTimer * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setUnarchiver:(ManagerUnarchiver *)unarchiver { %log; %orig; }
- (ManagerUnarchiver *)unarchiver { %log; ManagerUnarchiver * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (_Bool)isOfficialStoryCollaborator { %log; _Bool r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)_didReceiveAllUpdatesResponse:(id)arg1 { %log; %orig; }
- (void)didAddListener:(id)arg1 { %log; %orig; }
- (void)setUpdatesResponseAnnouncer:(id)arg1 { %log; %orig; }
- (id)preferredProfiledSelectorNames { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)clearExpiredCacheInBackground { %log; %orig; }
- (void)scheduleClearingExpiredCacheAfter:(double)arg1 { %log; %orig; }
- (void)requestStudySettingsWithDeviceIdHash:(id)arg1 backgroundQueue:(id)arg2 { %log; %orig; }
- (void)fetchRegisterStudySettings { %log; %orig; }
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 { %log; %orig; }
- (void)resetCentralPlayers { %log; %orig; }
- (void)initCentralPlayers { %log; %orig; }
- (void)postServerChallenge { %log; %orig; }
- (void)logConversationsResponse:(id)arg1 { %log; %orig; }
- (void)clearExpiredAndViewedStoriesWithCompletion:(id)arg1 { %log; %orig; }
- (void)resetAppIconBadgeNumber { %log; %orig; }
- (void)didAppStartupComplete { %log; %orig; }
- (_Bool)userHasValidRequest { %log; _Bool r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)willEnterForegroundFromRemoteNotification:(_Bool)arg1 { %log; %orig; }
- (void)didEnterBackground { %log; %orig; }
- (void)prepareForBecomeActiveFromRemoteNotification:(_Bool)arg1 { %log; %orig; }
- (void)prepareForResignActive { %log; %orig; }
- (void)startTimer:(id)arg1 source:(long long)arg2 { %log; %orig; }
- (void)startTimerIfNecessary { %log; %orig; }
- (void)markSnapAsViewed:(id)arg1 { %log; %orig; }
- (void)tick:(id)arg1 { %log; %orig; }
- (void)registerDeviceToken:(id)arg1 voipToken:(id)arg2 { %log; %orig; }
- (void)checkMobile { %log; %orig; }
- (void)verifyMobile:(id)arg1 shouldSkipConfirmation:(_Bool)arg2 type:(long long)arg3 isResetPassword:(_Bool)arg4 isFromDeepLink:(_Bool)arg5 withAllUpdates:(_Bool)arg6 { %log; %orig; }
- (void)verifyMobile:(id)arg1 shouldSkipConfirmation:(_Bool)arg2 isResetPassword:(_Bool)arg3 withAllUpdates:(_Bool)arg4 { %log; %orig; }
- (void)verifyMobile:(id)arg1 shouldSkipConfirmation:(_Bool)arg2 isResetPassword:(_Bool)arg3 { %log; %orig; }
- (void)verifyMobile:(id)arg1 shouldSkipConfirmation:(_Bool)arg2 isFromDeepLink:(_Bool)arg3 withAllUpdates:(_Bool)arg4 { %log; %orig; }
- (void)verifyMobileFromSettings:(id)arg1 type:(long long)arg2 isFromDeepLink:(_Bool)arg3 { %log; %orig; }
- (void)verifyMobilePreLogin:(id)arg1 phoneNumber:(id)arg2 usernameOrEmail:(id)arg3 countryCode:(id)arg4 preAuthToken:(id)arg5 { %log; %orig; }
- (void)_setMobile:(id)arg1 withCountryCode:(id)arg2 phoneCall:(_Bool)arg3 reverified:(_Bool)arg4 isResetPassword:(_Bool)arg5 usernameOrEmail:(id)arg6 preAuthToken:(id)arg7 { %log; %orig; }
- (void)setMobile:(id)arg1 withCountryCode:(id)arg2 phoneCall:(_Bool)arg3 usernameOrEmail:(id)arg4 preAuthToken:(id)arg5 { %log; %orig; }
- (void)setMobile:(id)arg1 withCountryCode:(id)arg2 phoneCall:(_Bool)arg3 reverified:(_Bool)arg4 { %log; %orig; }
- (void)verifyCaptchaWithId:(id)arg1 solution:(id)arg2 isResetPassword:(_Bool)arg3 usernameOrEmail:(id)arg4 successQueue:(id)arg5 completion:(id)arg6 { %log; %orig; }
- (void)fetchCaptchaImagesWithSuccessQueue:(id)arg1 isResetPassword:(_Bool)arg2 usernameOrEmail:(id)arg3 withCompletion:(id)arg4 { %log; %orig; }
- (void)getPasswordStrengthPreLogin:(id)arg1 quickCheck:(_Bool)arg2 preAuthToken:(id)arg3 usernameOrEmail:(id)arg4 onComplete:(id)arg5 { %log; %orig; }
- (void)changePassword:(id)arg1 isResetPassword:(_Bool)arg2 preAuthToken:(id)arg3 usernameOrEmail:(id)arg4 onComplete:(id)arg5 { %log; %orig; }
- (void)doLogoutRequest:(_Bool)arg1 { %log; %orig; }
- (void)logoutForced:(_Bool)arg1 { %log; %orig; }
- (void)forceLogout { %log; %orig; }
- (void)logout { %log; %orig; }
- (_Bool)shouldShowFeedLoadingView { %log; _Bool r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)loadMoreConversationsIfPossibleForceOnFailed:(_Bool)arg1 { %log; %orig; }
- (id)fetchConversationsFailureBlock { %log; id r = %orig; HBLogDebug(@" = 0x%lx", (uintptr_t)r); return r; }
- (void)_didFetchStoriesFailure:(id)arg1 { %log; %orig; }
- (void)_didFetchUpdatesFailure:(id)arg1 { %log; %orig; }
- (void)_didFetchStoriesSuccessWithOnLaunch:(_Bool)arg1 responseDictionary:(id)arg2 completionHandler:(id)arg3 { %log; %orig; }
- (id)fetchConversationsSuccessBlock { %log; id r = %orig; HBLogDebug(@" = 0x%lx", (uintptr_t)r); return r; }
- (_Bool)applyAllUpdatesResponse:(id)arg1 { %log; _Bool r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)updateCacheLimit { %log; %orig; }
- (id)fetchUpdatesSuccessBlock { %log; id r = %orig; HBLogDebug(@" = 0x%lx", (uintptr_t)r); return r; }
- (void)fetchStoriesOnLaunch:(_Bool)arg1 completionHandler:(id)arg2 { %log; %orig; }
- (void)fetchStories { %log; %orig; }
- (void)fetchAllConversationsWithParameters:(id)arg1 successBlock:(id)arg2 failureBlock:(id)arg3 { %log; %orig; }
- (void)fetchUpdatesWithCompletionHandler:(id)arg1 isAllUpdates:(_Bool)arg2 includeConversations:(_Bool)arg3 fromAppLaunch:(_Bool)arg4 { %log; %orig; }
- (void)fetchUpdatesSuccessWithResponse:(id)arg1 isAllUpdates:(_Bool)arg2 didPullToRefresh:(_Bool)arg3 fromAppLaunch:(_Bool)arg4 onCompletion:(id)arg5 { %log; %orig; }
- (void)fetchUpdates { %log; %orig; }
- (void)_unarchiveMoreConversations { %log; %orig; }
- (void)_fetchMoreConversations { %log; %orig; }
- (void)_fetchConversationsWithFriends:(_Bool)arg1 Completion:(id)arg2 { %log; %orig; }
- (void)fetchConversations { %log; %orig; }
- (void)fetchUpdatesFromLaunchIncludeConversations:(_Bool)arg1 { %log; %orig; }
- (void)fetchUpdatesAndStories { %log; %orig; }
- (id)parametersForFetchUpdates { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)markViewedStories:(_Bool)arg1 { %log; %orig; }
- (void)_flushLoggerEvents { %log; %orig; }
- (void)logFlushedEvents:(id)arg1 { %log; %orig; }
- (void)markViewedSnaps { %log; %orig; }
- (void)markViewedAddedFriends { %log; %orig; }
- (id)getUpdatedSnapsJsonWithUpdatedSnaps:(id)arg1 { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (id)getUpdatedSnapsDictionaryWithUpdatedSnaps:(id)arg1 { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)applyBackgroundFetchUpdates { %log; %orig; }
- (void)getUsernameSuggestionsOnRegisterFirstName:(id)arg1 lastName:(id)arg2 onComplete:(id)arg3 { %log; %orig; }
- (void)checkRequestedUsername:(id)arg1 onComplete:(id)arg2 { %log; %orig; }
- (void)registerWithFirstName:(id)arg1 lastName:(id)arg2 username:(id)arg3 password:(id)arg4 birthday:(id)arg5 { %log; %orig; }
- (void)_performPostQuickLoginUpdates:(id)arg1 { %log; %orig; }
- (void)finishRegistration { %log; %orig; }
- (id)jsonStringForEvents:(id)arg1 { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (id)authenticator_DO_NOT_USE_OR_YOU_WILL_BE_FIRED { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (id)username { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (id)authToken { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (_Bool)compareSeqno:(unsigned long long)arg1 { %log; _Bool r = %orig; HBLogDebug(@" = %d", r); return r; }
- (void)incSeqno { %log; %orig; }
- (unsigned long long)getSeqno { %log; unsigned long long r = %orig; HBLogDebug(@" = %llu", r); return r; }
- (_Bool)isUserCreated { %log; _Bool r = %orig; HBLogDebug(@" = %d", r); return r; }
- (id)init { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (id)friendManager { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString *)debugDescription { %log; NSString * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString *)description { %log; NSString * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (unsigned long long )hash { %log; unsigned long long  r = %orig; HBLogDebug(@" = %llu", r); return r; }
- (Class )superclass { %log; Class  r = %orig; HBLogDebug(@" = %@", r); return r; }
%end
