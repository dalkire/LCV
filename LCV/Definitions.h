//
//  Definitions.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#define IPHONE_OLD      1
#define IPHONE_RETINA   2
#define IPAD            3

#define NONE        0
#define WATCHING    200
#define TRAINING    201
#define ICC         300
#define FICS        301

#define CN_NONE				-999

#define CN_TELL				101
#define CN_I				102
#define CN_SHOUT			103
#define CN_SHOUT0			104
#define CN_SLASH			105
#define CN_WHO				106
#define CN_SET				107
#define CN_FLAG				108
#define CN_SAY				109
#define CN_CHANNELTELL		110
#define CN_SSHOUT			111
#define CN_BAD				112
#define CN_KIBITZ			113
#define CN_WHISPER			114
#define CN_EXAMINE			115
#define CN_MEXAMINE			116
#define CN_COPYGAME0		117
#define CN_COPYGAME			118
#define CN_FORWARD			119
#define CN_BACK				120
#define CN_MATCH			121
#define CN_MATCH0			122
#define CN_ACCEPT			123
#define CN_HELP0			124
#define CN_HELP				125
#define CN_MORE				126
#define CN_NEWS				127
#define CN_NEWS0			128
#define CN_HISTORY			129
#define CN_FINGER			130
#define CN_VARS				131
#define CN_UPSTATISTICS		132
#define CN_UNEXAMINE		133
#define CN_ADJOURN			134
#define CN_ASSESS			135
#define CN_OBSERVE0			136
#define CN_OBSERVE			137
#define CN_FOLLOW0			138
#define CN_FOLLOW			139
#define CN_ECO				140
#define CN_STYLE			141
#define CN_BELL				142
#define CN_OPEN				143
#define CN_DECLINE			144
#define CN_REFRESH			145
#define CN_RESIGNADJ		146
#define CN_REVERT			147
#define CN_RATED			148
#define CN_RANK				149
#define CN_MOVES			150
#define CN_MAILOLDMOVES		151
#define CN_MAILSTORED		152
#define CN_MAILHELP			153
#define CN_PENDING			154
#define CN_GAMES			155
#define CN_ABORT			156
#define CN_ALLOBSERVERS		157
#define CN_INCHANNEL		158
#define CN_INFO				159
#define CN_MORETIME			160
#define CN_BEST				161
#define CN_QUIT				162
#define CN_QUOTA			163
#define CN_LLOGONS			164
#define CN_LHISTORY			165
#define CN_LOGONS			166
#define CN_TIME				167
#define CN_TAKEBACK			168
#define CN_SEARCH			169
#define CN_SEARCH0			170
#define CN_SMOVES			171
#define CN_SPOSITION		172
#define CN_PASSWORD			173
#define CN_MESSAGE			174
#define CN_MESSAGE0			175
#define CN_CLEARMESSAGES	176
#define CN_DATE				177
#define CN_LIST				178
#define CN_PLUS				179
#define CN_MINUS			180
#define CN_ZNOTL			181
#define CN_FLIP				182
#define CN_PROMOTE			183
#define CN_EXPUNGE			184
#define CN_IWCMATCH			185
#define CN_LIMITS			186
#define CN_PING				187
#define CN_EXTEND			188
#define CN_QTELL			189
#define CN_GETPI			190
#define CN_STARTSIMUL		191
#define CN_GOTO				192
#define CN_SETCLOCK			193
#define CN_LIBLIST			194
#define CN_LIBSAVE			195
#define CN_LIBDELETE		196
#define CN_LIBANNOTATE		197
#define CN_LIBKEEPEXAM		198
#define CN_PARTNER			199
#define CN_PARTNER0			200
#define CN_PTELL			201
#define CN_BUGWHO			202
#define CN_WILDRANK			204
#define CN_XOBSERVE			205
#define CN_PRIMARY			206
#define CN_DRAW				207
#define CN_RESIGN			208
#define CN_STATISTICS		209
#define CN_STORED			210
#define CN_CHANNELQTELL		211
#define CN_XPARTNER			212
#define CN_YFINGER			213
#define CN_SEEKING			214
#define CN_SOUGHT			215
#define CN_SET2				216
#define CN_PLAY				217
#define CN_UNSEEKING		218
#define CN_AWAY				219
#define CN_LAGSTATS			220
#define CN_COMMANDS			221
#define CN_REMATCH			222
#define CN_REGISTER			223
#define CN_RESUME			224
#define CN_CIRCLE			225
#define CN_ARROW			226
#define CN_BLANKING			227
#define CN_RELAY			228
#define CN_LOADGAME			229
#define CN_DRAWADJ			230
#define CN_ABORTADJ			231
#define CN_MAILNEWS			232
#define CN_QSET				233
#define CN_CC_START			234
#define CN_CC_LIST			235
#define CN_CC_MOVE			236
#define CN_CC_DELETE		237
#define CN_CC_QSTART		238
#define CN_CC_QLIST			239
#define CN_CC_QLABEL		240
#define CN_CC_QDELETE		241
#define CN_CC_QADJUDICATE	242
#define CN_CC_ASK_DIRECTOR	243
#define CN_LOADFEN			244
#define CN_GETPX			245
#define CN_UNRELAYED		246
#define CN_NORELAY			247
#define CN_REFER			248
#define CN_PGN				249
#define CN_SPGN				250
#define CN_QFOLLOW			251
#define CN_QUNFOLLOW		252
#define CN_QMATCH			253
#define CN_QPARTNER			254
#define CN_ISREGNAME		255
#define CN_REQUIRETICKET	256
#define CN_ANNOTATE			257
#define CN_CLEARBOARD		258
#define CN_REQUEST_WIN		259
#define CN_REQUEST_DRAW		260
#define CN_REQUEST_ABORT	261
#define CN_LOGPGN			262
#define CN_RESULT			263
#define CN_FEN				264
#define CN_SFEN				265
#define CN_SETGAMEPARAM		266
#define CN_TAG				267
#define CN_TOMOVE			268
#define CN_REGENTRY			269
#define CN_PERSONALINFO		270
#define CN_EVENTS			271
#define CN_QADDEVENT		272
#define CN_GLISTGROUPS		273
#define CN_GLISTMEMBERS		274
#define CN_GINVITE			275
#define CN_GJOIN			276
#define CN_GLISTINVITED		277
#define CN_GLISTJOINING		278
#define CN_GDESCRIBE		279
#define CN_GKICK			280
#define CN_GBEST			281
#define CN_SIMULIZE			282
#define CN_GAMEID			283
#define CN_FIVEMINUTE		284
#define CN_QIMPART			285 
#define CN_GMESSAGE			286
#define CN_COMPLAIN			287
#define CN_LASTTELLS		288
#define CN_VIEW				289
#define CN_SHOWADMIN		290
#define CN_PSTAT			291
#define CN_BOARDINFO		292

#define DG_WHO_AM_I                     0
#define DG_PLAYER_ARRIVED               1
#define DG_PLAYER_LEFT                  2
#define DG_BULLET                       3
#define DG_BLITZ                        4
#define DG_STANDARD                     5
#define DG_WILD                         6
#define DG_BUGHOUSE                     7
#define DG_TIMESTAMP                    8
#define DG_TITLES                       9
#define DG_OPEN                         10
#define DG_STATE                        11
#define DG_GAME_STARTED                 12
#define DG_GAME_RESULT                  13
#define DG_EXAMINED_GAME_IS_GONE        14
#define DG_MY_GAME_STARTED              15
#define DG_MY_GAME_RESULT               16
#define DG_MY_GAME_ENDED                17
#define DG_STARTED_OBSERVING            18
#define DG_STOP_OBSERVING               19
#define DG_PLAYERS_IN_MY_GAME           20
#define DG_OFFERS_IN_MY_GAME            21
#define DG_TAKEBACK                     22
#define DG_BACKWARD                     23
#define DG_SEND_MOVES                   24
#define DG_MOVE_LIST                    25
#define DG_KIBITZ                       26
#define DG_PEOPLE_IN_MY_CHANNEL         27
#define DG_CHANNEL_TELL                 28
#define DG_MATCH                        29
#define DG_MATCH_REMOVED                30
#define DG_PERSONAL_TELL                31
#define DG_SHOUT                        32
#define DG_MOVE_ALGEBRAIC               33
#define DG_MOVE_SMITH                   34
#define DG_MOVE_TIME                    35
#define DG_MOVE_CLOCK                   36
#define DG_BUGHOUSE_HOLDINGS            37
#define DG_SET_CLOCK                    38
#define DG_FLIP                         39
#define DG_ISOLATED_BOARD               40
#define DG_REFRESH                      41
#define DG_ILLEGAL_MOVE                 42
#define DG_MY_RELATION_TO_GAME          43
#define DG_PARTNERSHIP                  44
#define DG_SEES_SHOUTS                  45
#define DG_CHANNELS_SHARED              46
#define DG_MY_VARIABLE                  47
#define DG_MY_STRING_VARIABLE           48
#define DG_JBOARD                       49
#define DG_SEEK                         50
#define DG_SEEK_REMOVED                 51
#define DG_MY_RATING                    52
#define DG_SOUND                        53
#define DG_PLAYER_ARRIVED_SIMPLE        55
#define DG_MSEC                         56
#define DG_BUGHOUSE_PASS                57
#define DG_IP                           58
#define DG_CIRCLE                       59
#define DG_ARROW                        60
#define DG_MORETIME                     61
#define DG_PERSONAL_TELL_ECHO           62
#define DG_SUGGESTION                   63
#define DG_NOTIFY_ARRIVED               64
#define DG_NOTIFY_LEFT                  65
#define DG_NOTIFY_OPEN                  66
#define DG_NOTIFY_STATE                 67
#define DG_MY_NOTIFY_LIST               68
#define DG_LOGIN_FAILED                 69
#define DG_FEN                          70
#define DG_TOURNEY_MATCH                71
#define DG_GAMELIST_BEGIN               72
#define DG_GAMELIST_ITEM                73
#define DG_IDLE                         74
#define DG_ACK_PING                     75
#define DG_RATING_TYPE_KEY              76
#define DG_GAME_MESSAGE                 77
#define DG_UNACCENTED                   78
#define DG_STRINGLIST_BEGIN             79
#define DG_STRINGLIST_ITEM              80
#define DG_DUMMY_RESPONSE               81
#define DG_CHANNEL_QTELL                82
#define DG_PERSONAL_QTELL               83
#define DG_SET_BOARD                    84
#define DG_MATCH_ASSESSMENT             85
#define DG_LOG_PGN                      86
#define DG_NEW_MY_RATING                87
#define DG_LOSERS                       88
#define DG_UNCIRCLE                     89
#define DG_UNARROW                      90
#define DG_WSUGGEST                     91
#define DG_TEMPORARY_PASSWORD           93
#define DG_MESSAGELIST_BEGIN            94
#define DG_MESSAGELIST_ITEM             95
#define DG_LIST                         96
#define DG_SJI_AD                       97
#define DG_RETRACT                      99
#define DG_MY_GAME_CHANGE               100
#define DG_POSITION_BEGIN               101
#define DG_TOURNEY                      103
#define DG_REMOVE_TOURNEY               104
#define DG_DIALOG_START                 105
#define DG_DIALOG_DATA                  106
#define DG_DIALOG_DEFAULT               107
#define DG_DIALOG_END                   108
#define DG_DIALOG_RELEASE               109
#define DG_POSITION_BEGIN2              110
#define DG_PAST_MOVE                    111
#define DG_PGN_TAG                      112
#define DG_IS_VARIATION                 113
#define DG_PASSWORD                     114
#define DG_WILD_KEY                     116
#define DG_SWITCH_SERVERS               120
#define DG_SET2                         124
#define DG_FIVEMINUTE                   125
#define DG_ONEMINUTE                    126
#define DG_TRANSLATIONOKAY              129
#define DG_UID                          131
#define DG_KNOWS_FISCHER_RANDOM         132
#define DG_COMMAND                      136
#define DG_TOURNEY_GAME_STARTED         137
#define DG_TOURNEY_GAME_ENDED           138
#define DG_MY_TURN                      139
#define DG_CORRESPONDENCE_RATING        140
#define DG_DISABLE_PREMOVE              141
#define DG_PSTAT                        142
#define DG_BOARDINFO                    143
#define DG_MOVE_LAG                     144
#define DG_FIFTEENMINUTE                145

#define SQUARE_A1	CGPointMake(20, 300)
#define SQUARE_A2	CGPointMake(20, 260)
#define SQUARE_A3	CGPointMake(20, 220)
#define SQUARE_A4	CGPointMake(20, 180)
#define SQUARE_A5	CGPointMake(20, 140)
#define SQUARE_A6	CGPointMake(20, 100)
#define SQUARE_A7	CGPointMake(20, 60)
#define SQUARE_A8	CGPointMake(20, 20)
#define SQUARE_B1	CGPointMake(60, 300)
#define SQUARE_B2	CGPointMake(60, 260)
#define SQUARE_B3	CGPointMake(60, 220)
#define SQUARE_B4	CGPointMake(60, 180)
#define SQUARE_B5	CGPointMake(60, 140)
#define SQUARE_B6	CGPointMake(60, 100)
#define SQUARE_B7	CGPointMake(60, 60)
#define SQUARE_B8	CGPointMake(60, 20)


