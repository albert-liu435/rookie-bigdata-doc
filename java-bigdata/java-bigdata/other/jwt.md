## 已读
[JSON Web Token 入门教程](https://www.ruanyifeng.com/blog/2018/07/json_web_token-tutorial.html)

[JSON Web Token](https://blog.csdn.net/m0_54355172/article/details/128070287)

[什么是 JSON Web Token](https://zhuanlan.zhihu.com/p/656901915)

[利用JWT生成Token的原理及公钥和私钥加密和解密的原则](https://blog.csdn.net/weixin_42030357/article/details/95629924)

[JWT教程：生成私钥和公钥、生成jwt令牌、验证jwt令牌](https://blog.csdn.net/a772304419/article/details/132086175)

[【SSO单点登录】JWT如何防篡改&&主动注销【黑白名单机制】](https://blog.csdn.net/m0_57042151/article/details/127295145)

[JWT 介绍和使用,对称加密，非对称加密，RSA, Tocken？](https://blog.51cto.com/u_15127630/3892206)

## 正在读



## JWT
### JWT组成
JWT 的三个部分依次如下。  
Header（头部）  
Payload（负载） 
Signature（签名）   
写成一行，就是下面的样子。   
Header.Payload.Signature    
#### Header
Header 部分是一个 JSON 对象，描述 JWT 的元数据，通常是下面的样子。  
{
"alg": "HS256",
"typ": "JWT"
}   
上面代码中，alg属性表示签名的算法（algorithm），默认是 HMAC SHA256（写成 HS256）；typ属性表示这个令牌（token）的类型（type），JWT 令牌统一写为JWT。

最后，将上面的 JSON 对象使用 Base64URL 算法（详见后文）转成字符串。  
#### Payload
Payload 部分也是一个 JSON 对象，用来存放实际需要传递的数据。JWT 规定了7个官方字段，供选用。
iss (issuer)：签发人    
exp (expiration time)：过期时间  
sub (subject)：主题    
aud (audience)：受众   
nbf (Not Before)：生效时间   
iat (Issued At)：签发时间    
jti (JWT ID)：编号
除了官方字段，你还可以在这个部分定义私有字段，下面就是一个例子。    
{
"sub": "1234567890",
"name": "John Doe",
"admin": true
}   
注意，JWT 默认是不加密的，任何人都可以读到，所以不要把秘密信息放在这个部分。

这个 JSON 对象也要使用 Base64URL 算法转成字符串。

### Signature
Signature 部分是对前两部分的签名，防止数据篡改。

首先，需要指定一个密钥（secret）。这个密钥只有服务器才知道，不能泄露给用户。然后，使用 Header 里面指定的签名算法（默认是 HMAC SHA256），按照下面的公式产生签名。
HMACSHA256(
base64UrlEncode(header) + "." +
base64UrlEncode(payload),
secret) 

算出签名以后，把 Header、Payload、Signature 三个部分拼成一个字符串，每个部分之间用"点"（.）分隔，就可以返回给用户。
#### Base64URL
前面提到，Header 和 Payload 串型化的算法是 Base64URL。这个算法跟 Base64 算法基本类似，但有一些小的不同。

JWT 作为一个令牌（token），有些场合可能会放到 URL（比如 api.example.com/?token=xxx）。Base64 有三个字符+、/和=，在 URL 里面有特殊含义，所以要被替换掉：=被省略、+替换成-，/替换成_ 。这就是 Base64URL 算法。
### JWT 的几个特点
（1）JWT 默认是不加密，但也是可以加密的。生成原始 Token 以后，可以用密钥再加密一次。

（2）JWT 不加密的情况下，不能将秘密数据写入 JWT。

（3）JWT 不仅可以用于认证，也可以用于交换信息。有效使用 JWT，可以降低服务器查询数据库的次数。

（4）JWT 的最大缺点是，由于服务器不保存 session 状态，因此无法在使用过程中废止某个 token，或者更改 token 的权限。也就是说，一旦 JWT 签发了，在到期之前就会始终有效，除非服务器部署额外的逻辑。

（5）JWT 本身包含了认证信息，一旦泄露，任何人都可以获得该令牌的所有权限。为了减少盗用，JWT 的有效期应该设置得比较短。对于一些比较重要的权限，使用时应该再次对用户进行认证。

（6）为了减少盗用，JWT 不应该使用 HTTP 协议明码传输，要使用 HTTPS 协议传输。
