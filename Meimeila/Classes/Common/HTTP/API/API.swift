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
	static let baseServer = "http://120.26.104.21/"
}

// MARK: - 首页
extension API {
    
    /// 首页
    // 首页推荐列表
    static let homeData = "tpiot/app/shoptop"
    
    // 签到红包
    static let addSignRed = "makeMoney/addSignRed.php"
    
    // 提现记录
    static let getWithdrawalsInfo = "makeMoney/getWithdrawalsInfo.php"
    
    // 提现申请
    static let  addWithdrawals = "makeMoney/addWithdrawals.php"
    
    // 系统消息
    static let  getSystemNotice = "notice/getSystemNotice.php"
}

// MARK: - 发现
extension API {
    
    static let getFoundBrand = "shoping/getFoundBrand.php"
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
    static let addShoppingCart = "shoping/addShoppingCart.php"
    
    // 商品评价点赞
    static let addShopFabulous = "shoping/addShopFabulous.php"
    
    // 取消商品评价点赞
    static let delShopFabulous = "shoping/delShopFabulous.php"
    
    // 获取商品评价列表
    static let getEvaluation = "shoping/getEvaluation.php"
    
    // 商品搜索
    static let searchProduct = "shoping/getQueryShopping.php"
    
    // 热搜
    static let hotSearchKeyword = "shoping/getHot.php"
    
    /// 商品结算页相关
    // 支付宝支付
    static let getAlipayOrders = "alipay/getAlipayOrders.php"
    
    // 微信支付
    static let getWechapayOrders = "wechaPay/getWechapayOrders.php"
    
    // 获取默认地址
    static let getDefaultAddress = "shoping/getDefaultAddress.php"
    
    
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
    static let share = "shoping/share.php"
}

// MARK: - 我的相关
extension API {
    
    /// 个人中心相关
    // 用户登录
    //static let login = "user/login.php"
	static let login = "tpiot/app/login"
    
    //微信登录
    static let login_weChat = "user/login_weixin_qq.php"
    
    // 用户注册
    static let register = "tpiot/app/register"
    
    // 获取注册验证码
    static let smsCode = "tpiot/app/vercode"
    
    // 上传极光推送registerID
    static let getRegistrationID = "user/getRegistrationID.php"
    
    // 找回密码
    static let findPassword = "user/findPassword.php"
    
    // 修改密码
    static let checkPassword = "user/checkPassword.php"
    
    //验证token
    static let checkToken = "user/checkLoginToken.php"
    
    //退出登录
    static let userLogout = "tpiot/app/loginout"
    
    //修改头像
    static let feedbackImg = "user/feedbackImg.php"
    
    //用户资料
    static let userInfoAPI = "tpiot/app/getuserinfo"
    
    //会员等级
    static let memberLevelAPI = "tpiot/app/getMembershipCard"
    
    //修改用户资料
    static let userInfoUpDataAPI = "tpiot/app/usrprofile"
    
    
    //商品收藏列表
    static let shopCollectListAPI = "tpiot/app/getcollecinfo"
    
    ///订单
    //全部订单
    static let allOrderAPI = "shoping/selectOrder.php"
    
    //待付款订单
    static let waitPayOrderAPI = "shoping/selectPaymentOrder.php"
    
    //待发货订单
    static let waitSendOrderAPI = "shoping/selectPaymentOrder.php"
    
    //待收货订单
    static let waitGetOrderAPI = "shoping/selectPaymentOrder.php"
    
    //待评价订单
    static let waitCommentOrderAPI = "shoping/selectPaymentOrder.php"
    
    //正在申请退款订单
    static let reimburseNowAPI = "shoping/selectPaymentOrder.php"
    
    //已退款订单
    static let reimburseFinishAPI = "shoping/selectPaymentOrder.php"
    
    //删除订单
    static let deleteOrderAPI = "shoping/delOrder.php"
    
    //取消订单
    static let cancleOrderAPI =  "shoping/cancelOrders.php"
    
    
    //订单详情
    static let orderDetailAPI = "shoping/selectPaymentOrder.php"
    
    //查看物流
    static let logisticsAPI = "notice/express_api/express_api.php"
    
    ///确认收货
    static let verifyTakeGoods = "shoping/confirmReceipt.php"
    
    
    ///售后
    //售后退款列表
    static let afterSaleListAPI = "shoping/getAfterSaleList.php"
    
    //售后退款详情
    static let afterSaleDetailAPI = "shoping/getReturnMoneyDetail.php"
    
    //申请售后
    static let afterSaleApplyAPI = "shoping/addAfteSalesApplication.php"
    
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
    static let moneyRechargeAPI = "wechaPay/getWechapayOrders.php"
    
    ///明细
    static let detailAPI = "tpiot/app/moneyDetail"
    
    ////面膜
    ///上传面膜测试数据
    static let maskDataupLoadAPI = "smart/getMaskData.php"
    
    ///面膜数据列表
    static let maskDataListAPI = "smart/getUserMaskData.php"
    
    ///上传评论
    static let commentAPI = "shoping/addEvaluete.php"
    
    ///意见反馈
    static let feedbackAPI = "user/feedbackMessage.php"
    
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
    static let momeyPayOrderAPI = "shoping/banlancePay.php"
    
    ///健康豆充值
    static let moneyPayHealthBeanAPI = "shoping/banlancePay.php"
    
    ///设置或修改余额支付密码
    static let moneyPay_PW_API = "user/payment_pwd.php"
    
    ///绑定手机号
    static let moneyPayBindPhoneAPI = "tpiot/app/bindphone"
}


extension API{
    //中奖纪录
    static let luckDrawRecordAPI = "pan/myPrize.php";
    
    ///兑换记录
    static let exchangeGiftAPI = "pan/exchangeRecord.php";
    
    ///兑换奖品
    static let exchangeGift2_0API = "pan/payForPrize.php";
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
