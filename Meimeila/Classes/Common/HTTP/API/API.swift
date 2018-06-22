//
//  API.swift
//  HTTPClientDemo
//
//  Created by HJQ on 2017/9/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation

// MARK: - API接口地址
struct API {
    
    // 服务器地址
    //static let baseServer = "http://ml.nnddkj.com/meimeila/API/"
	//static let baseServer = "http://120.26.104.21/"
	static let baseServer = "http://yg.welcare-tech.com.cn/"
	
}

// MARK: - 首页
extension API {
    
    /// 首页
    // 首页推荐列表
    static let homeData = "tpiot/app/shoptop"
    
    // 广告
    static let splashData = "tpiot/app/startup"
    
    // 签到红包
    static let addSignRed = "tpiot/app/addSignRed"
    
    // 提现记录
    static let getWithdrawalsInfo = "tpiot/app/getwithdrawalsinfo"
    
    // 提现申请
    static let  addWithdrawals = "tpiot/app/addWithdrawals"
    
    // 系统消息
    static let  getSystemNotice = "tpiot/app/getsystemnotice"
}

// MARK: - 发现
extension API {
    
    static let getFoundBrand = "tpiot/app/getfoundbrand"
}

// MARK: - 硬件相关
extension API {
    
}

// MARK: - 商城相关
extension API {
    /// 商城相关
    // 商品详情
    static let productDetails = "tpiot/app/productdetails"
    
    // 商品详情领取抵现红包
    static let useRedPackets = "user/useRedPackets.php"
    
    // 商品添加收藏
    static let addShopCollection = "tpiot/app/addshopcollection"
    
    // 取消商品收藏
    static let delShopCollection = "tpiot/app/delshopcollection"
    
    // 商品是否收藏
    static let isCollection = "shoping/isCollection.php"
    
    // 添加到购物车
    static let addShoppingCart = "tpiot/app/addshoppingcart"
    
    // 商品评价点赞
    static let addShopFabulous = "tpiot/app/addShopFabulous"
    
    // 取消商品评价点赞
    static let delShopFabulous = "tpiot/app/delShopFabulous"
    
    // 获取商品评价列表
    static let getEvaluation = "tpiot/app/getEvaluation"
    
    // 商品搜索
    static let searchProduct = "tpiot/app/getQueryShopping"
    
    // 热搜
    static let hotSearchKeyword = "tpiot/app/getHot"
    
    /// 商品结算页相关
    // 支付宝支付
    static let getAlipayOrders = "tpiot/alipay/getAlipayOrders"
    
    // 微信支付
    static let getWechapayOrders = "tpiot/app/wechaPay/getWechapayOrders"
    
    // 获取默认地址
    static let getDefaultAddress = "tpiot/app/getDefaultAddress"
    
    
    /// 购物车相关
    // 获取购物车列表
    static let shoppingcarList = "tpiot/app/getshoppingcartinfo"
    
    // 购物车数量增加
    static let productIncrease = "tpiot/app/addshoppingcartnumber"
    
    // 购物车数量减少
    static let productDeIncrease = "tpiot/app/delshoppingcartnumber"
    
    // 删除购物车商品
    static let productDeleted = "tpiot/app/delshoppingcart"
    
    // 分享
    static let share = "tpiot/app/share"
}

// MARK: - 我的相关
extension API {
	
	// checkStitch
	static let  checkswitch = "tpiot/app/deleteswitch"
	
    /// 个人中心相关
    // 用户登录
    //static let login = "user/login.php"
	static let login = "tpiot/app/login"
    
    //微信登录
    static let login_weChat = "tpiot/app/otherLogin"
    
    // 用户注册
    static let register = "tpiot/app/register"
    
    // 获取注册验证码
    static let smsCode = "tpiot/app/vercode"
    
    // 上传极光推送registerID
    static let getRegistrationID = "user/getRegistrationID.php"
    
    // 找回密码
    static let findPassword = "tpiot/app/restpwd"
    
    // 修改密码
    static let checkPassword = "tpiot/app/restpwd"
    
    //验证token
    static let checkToken = "user/checkLoginToken.php"
    
    //退出登录
    static let userLogout = "tpiot/app/loginout"
    
    //修改头像
    static let feedbackImg = "tpiot/app/feedbackimg"
    
    //用户资料
    static let userInfoAPI = "tpiot/app/getuserinfo"
    
    //会员等级
    static let memberLevelAPI = "tpiot/app/getMembershipCard"
    
    //修改用户资料
    static let userInfoUpDataAPI = "tpiot/app/updateuserinfo"
    
    
    //商品收藏列表
    static let shopCollectListAPI = "tpiot/app/getcollecinfo"
    
    ///订单
    //全部订单
    static let allOrderAPI = "tpiot/app/selectOrder"
    
    //待付款订单
    static let waitPayOrderAPI = "tpiot/app/selectPaymentOrder"
    
    //待发货订单
    static let waitSendOrderAPI = "tpiot/app/selectPaymentOrder"
    
    //待收货订单
    static let waitGetOrderAPI = "tpiot/app/selectPaymentOrder"
    
    //待评价订单
    static let waitCommentOrderAPI = "tpiot/app/selectPaymentOrder"
    
    //正在申请退款订单
    static let reimburseNowAPI = "tpiot/app/selectPaymentOrder"
    
    //已退款订单
    static let reimburseFinishAPI = "tpiot/app/selectPaymentOrder"
    
    //删除订单
    static let deleteOrderAPI = "tpiot/app/delOrder"
    
    //取消订单
    static let cancleOrderAPI =  "shoping/cancelOrders.php"
    
    
    //订单详情
    static let orderDetailAPI = "tpiot/app/selectPaymentOrder"
    
    //查看物流
    static let logisticsAPI = "notice/express_api/express_api.php"
    
    ///确认收货
    static let verifyTakeGoods = "tpiot/app/confirmReceipt"
    
    
    ///售后
    //售后退款列表
    static let afterSaleListAPI = "shoping/getAfterSaleList.php"
    
    //售后退款详情
    static let afterSaleDetailAPI = "tpiot/app/getReturnMoneyDetail"
    
    //申请售后
    static let afterSaleApplyAPI = "tpiot/app/addAfteSalesApplication"
    
    ///微信申请退款
    static let refundCash_weChatPayAPI = "wechaPay/refundWechapayOrder.php"
    
    ///支付宝申请退款
    static let refundCash_aliPayAPI = "alipay/refundAlipayOrders.php"

    
    ///消息
    //用户消息
    static let customerMessageAPI = "tpiot/app/notice"
    //系统消息
    static let systemMessageAPI = ""
    
    ///收货地址
    
    //收货地址列表
    static let addressListAPI = "tpiot/app/getReceiptAddress"
    
    //新增收货地址
    static let addNewAddressAPI = "tpiot/app/receiptaddress"
    
    //修改收货地址
    static let modifiedAddressAPI = "tpiot/app/updateOrder"
    
    //修改订单的收货地址
    static let orderAddressSelect = "tpiot/app/updateOrder"
    
    //删除收货地址
    static let deleteAddressAPI = "tpiot/app/deletereceiptaddress"
    
    //获取默认收货地址
    static let defaultAddressAPI = "tpiot/app/getDefaultAddress"
    
    ///钱包余额
	static let moneyBalanceAPI = "tpiot/app/selectMoney"
    
    ///钱包充值
    static let moneyRechargeAPI = "tpiot/app/wechaPay/getWechapayOrders"
    
    ///明细
    static let detailAPI = "tpiot/app/moneyDetail"
    
    ////面膜
    ///上传面膜测试数据
    static let maskDataupLoadAPI = "tpiot/app/getmask"
    
    ///面膜数据列表
    static let maskDataListAPI = "tpiot/app/getUserMaskData"
    
    ///上传评论
    static let commentAPI = "tpiot/app/addEvaluete"
    
    ///意见反馈 + 商家入驻
    static let feedbackAPI = "tpiot/app/usropinon"
	
	
    ///每日任务
    static let dayTaskAPI = "tpiot/app/getTask"

    
    //音乐
    ///听音乐
    static let musicListen = "music/music.php"
    ///音乐列表
    static let musicList = "music/getsongs.php"

}

// MARK: - 余额支付
extension API {
    ///获取资金记录
    static let moneyPayRecordAPI = "makeMoney/getMoneyRecord.php"
    
    ///余额支付商品订单
    static let momeyPayOrderAPI = "tpiot/app/banlancePay"
    
    ///健康豆充值
    static let moneyPayHealthBeanAPI = "tpiot/app/banlancePay"
    
    ///设置或修改余额支付密码
    static let moneyPay_PW_API = "tpiot/app/paymentpwd"
    
    ///绑定手机号
    static let moneyPayBindPhoneAPI = "tpiot/app/bindphone"
}


extension API{
    //中奖纪录
    static let luckDrawRecordAPI = "tpiot/app/myPrize";
    
    ///兑换记录
    static let exchangeGiftAPI = "tpiot/app/exchangeRecord";
    
    ///兑换奖品
    static let exchangeGift2_0API = "tpiot/app/payForPrize";
}

// MARK: - 健康豆
extension API {
    ///健康豆个数
    static let healthBeansAPI = "tpiot/app/getBeans";
    
    ///健康豆记录
    static let healthBeansRecordAPI = "tpiot/app/beansDetail"
    
    ///健康豆兑换余额
    static let beansToMoneyExchangeAPI = "tpiot/app/exchange"
    
    ///健康豆换余额比率
    static let beansToMoneyExchangeRateAPI = "user/exchange.php"
    
}

extension API{
    ///联系客服
    static let contactServiceAPI = "tpiot/app/contact"
	
}

extension API {
	///检查邀请码
	static let checkInvitatiobCodeAPI = "tpiot/app/checkInvitationCode"
	// 省/市/级合伙人
	static let writeRegionAPI = "tpiot/app/writeRegion"
	// 提交申请资料
	static let writeApplyMsgAPI = "tpiot/app/writeJoin"
	// 获取默认邀请码
	static let getToExamineoneUidAPI = "tpiot/app/getToExamineoneUid"
	//获取代理管理数据
    static let getAgentManageData = "tpiot/app/getAgentManage"
	//获取 区域统计数据
	static let getAllRegionShoppingData = "tpiot/app/getAllRegionShopping"
	
	//获取订单管理数据
	static let getSubordinateShoppingData = "tpiot/app/getSubordinateShopping"
	
	// 拒绝代理 、
	static let agreeAgent = "tpiot/app/agreeAgent"
	
	// 同意
	static let agreeRegion = "tpiot/app/agreeRegion"
	
}
