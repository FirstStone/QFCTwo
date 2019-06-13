//
//  Square_WD_Model.h
//  QFC
//
//  Created by tiaoxin on 2019/5/16.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Square_WD_Model : NSObject

/**
 "id": 9,
 "uid": 1,
 "type_id": 4,
 "nickname": "Xutao",
 "avatar": "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",
 "content": "爱上大部分看到客服那是快递费卡士大夫阿斯蒂芬",
 "address": "地址",
 "createtime": 1165198156,
 "like_sum": "",
 "share_sum": 0,
 "discuss_sum": "",
 "answer_name": "",
 "answer_content": "",
 "answer_img": "",
 "answer_id": "",
 "type": 3,
 "likestatus": 0
 */

@property (nonatomic, strong) NSString *WD_id;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *type_id;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *like_sum;
@property (nonatomic, strong) NSString *share_sum;
@property (nonatomic, strong) NSString *discuss_sum;
@property (nonatomic, strong) NSString *answer_name;
@property (nonatomic, strong) NSString *answer_content;
@property (nonatomic, strong) NSString *answer_img;
@property (nonatomic, strong) NSString *answer_id;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *likestatus;

@end

@interface Square_info_Model : NSObject
/**
 "id": 1,
 "content": "你认为那个城市最适合居住?",
 "discuss_sum": 1,
 "answer_name": "Horizon",
 "answer_content": "长沙，湖南省省会，是长江中游地区重要的中心城市 [1]  ，全国“两型社会”综合配套改革试验区、中国重要的粮食生产基地，长江中游城市群和长江经济带重要的节点城市。 [2-3]  湖南省政治、经济、文化、交通、科技、金融、信息中心。东邻江西省宜春、萍乡，西连娄底、益阳，南接株洲、湘潭，北靠岳阳。长沙是全国性综合交通枢纽，京广高铁、沪昆高铁、渝厦高铁在此交汇。\r\n长沙位于湖南省东部偏北，湘江下游和长浏盆地西缘。总面积11819平方公里；辖6个区、1个县、代管2个县级市；2017年，常住人口791.81万，城镇化率77.59%，地区生产总值10535.51亿元。 [4]  境内地势起伏较大，地貌类型多样，地表水系发达。气候温和，四季分明，湘江穿城而过。\r\n长沙是首批国家历史文化名城，历经三千年城名、城址不变，有“屈贾之乡”、“楚汉名城”、“潇湘洙泗”之称。 [2]  存有马王堆汉墓、四羊方尊、三国吴简、岳麓书院、铜官窑等历史遗迹。凝练出“经世致用、兼收并蓄”的湖湘文化。 [3]  长沙既是清末维新运动和旧民主主义革命策源地之一，又是新民主主义的发祥地之一。 [5]  走出了黄兴、蔡锷，孕育了毛泽东、刘少奇等名人。 [3] \r\n长沙是中国（大陆）国际形象最佳城市、 [6]  东亚文化之都、 [7]  世界“媒体艺术之都。 [8-9]  打造了“电视湘军”、“出版湘军”、“动漫湘军”等文化品牌。 [3]  长沙有高校51所， [10]  独立科研机构97家，两院院士52名，国家工程技术研究中心14家，国家重点工程实验室15个；有杂交水稻育种、“天河”超级计算机、国内首台3D烧结打印机等科研成果。",
 "answer_img": "https://www.txkuaiyou.com/uploads/fileimg/1547088900652-2019-01-10.jpg",
 "type": 2,
 "answer_id": 2
 */
@property (nonatomic, strong) NSString *info_id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *discuss_sum;
@property (nonatomic, strong) NSString *answer_name;
@property (nonatomic, strong) NSString *answer_content;
@property (nonatomic, strong) NSString *answer_img;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *answer_id;

@end

@interface Square_carousel_Model : NSObject

/**
 "id": 1,
 "content": "你认为那个城市最适合居住?"
 */
@property (nonatomic, strong) NSString *carousel_id;
@property (nonatomic, strong) NSString *content;

@end


@interface Square_address_Model : NSObject

/**
 "id": 5,
 "uid": 2,
 "nickname": "Horizon",
 "avatar": "https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI1DcJmzT9WdomNdqicy3hSzictdyyfOib6SKjj50s8pKhojURBdjRLX5Q4GicKvvuQECUxib0l5tcC2Ww/132",
 "type_id": 4,
 "content": "发送快递费看见爱上的接口分布爱是",
 "transmit_id": 0,
 "discuss_sum": 1,
 "distance": 3167
 */

@property (nonatomic, strong) NSString *address_id;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *type_id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *transmit_id;
@property (nonatomic, strong) NSString *discuss_sum;
@property (nonatomic, strong) NSString *distance;

@end

NS_ASSUME_NONNULL_END
