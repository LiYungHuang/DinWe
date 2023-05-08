import React, { Component } from "react";

import A1 from '../images/tree1.jpg';
import A2 from "../images/2.png";
import A3 from "../images/3.png";
import A4 from "../images/4.png";
import B1 from '../images/member1.jpg';
import B2 from "../images/m2.jpg";
import B3 from "../images/m3.jpg";
import B4 from "../images/m4.jpg";

// import BG1 from "../images/BG1.jpg"
// var Bg = {
//   backgroundImage: `url(${BG1})`,
//   // borderRadius: "30px",
//   backgroundSize: "cover",
//   backgroundPosition: "center",
//   backgroundRepeat: "no-repeat",
//   // height: "100vh",
// };

class Infomation extends Component {
  state = {
    infos: [
      // {
      //   resturant_id:1,
      //   img: A1,
      //   headShot:B1,
      //   uName: "郭紀伸",
      //   alt: "大樹先生親子餐廳",
      //   rName: "大樹先生",
      //   teg1: "現金支付",
      //   teg2: "玩具區",
      //   teg3: "抓周活動",
      //   teg4: "沙坑",
      //   teg5: "素食",
      //   fraction: "3",
      //   frequency: "(共10則評價)",
      //   content:
      //     "一個以孩子為主角的空間球池的專家-大樹先生 專屬的大樹專用球，除了有CE認證，您也可以看到上面有大樹的Logo。 夢幻、瘋狂、嗨翻，都是球池區的代名詞，它具有無法阻擋的吸引力，是小朋友的最愛。 在球海波浪中盡情翻滾跳躍，在爬坡、索橋、廊道、滑梯、球池的循環中，小孩不知不覺的學會了平衡、律動、及肢體協調，藉由短距接觸，建立禮讓的人際規則。",
      //   message:
      //     "昨天在這邊舉辦了寶寶的週歲生日和抓周活動，感到非常滿意！ 從前期的聯繫，到後續的佈置及餐點安排，還有現場的服務跟抓周老師都非常到位，可圈可點！ 大人小孩都吃的滿足、玩得盡興，也滿足到媽媽想要給寶寶一個難得的回憶跟紀念的心❤️ CP值非常高👍 未來有要在辦小朋友的趴踢也有可能再在這裡舉辦",
      //   date: "2023-05-01",
      // },
      {
        resturant_id:2,
        img: A2,
        headShot:B2,
        uName: "賴姿吟",
        alt: "大家書房",
        rName: "大家書房",
        teg1: "現金支付",
        teg2: "免費 Wi-Fi",
        teg3: "爬行專區",
        teg4: "兒童書區",
        teg5: "衛生防護",
        fraction: "4.0",
        frequency: "(共30則評價)",
        content:
          "大家書房,由眷村平房屋改建而成的書房，原本就單存閱讀跟讀書會，就在最近也加入了咖啡的行列，他們就在中義眷村的汝鎏公園裡面、一切美好而寧靜，也的確是個喝咖啡看書的好地方，目前只有假日營業，如果想要靜靜地喝杯咖啡，這裡不失為是個好地方。",
        message:
          "店裡有九個人在經營 九個不同的專業 所以有九張名片 九張名片的窗戶各有不同 可能跟這個社區的多元有點像 裡面的書都是成員各自推選的 有山系 有童話繪本 都有明顯的差異 可以喝茶 喝咖啡 翻翻書 沒想到大雅 會有一間這麼讚的獨立書店 也可以索取忠義村的探險地圖",
        date: "2023-04-20",
      },
      {
        resturant_id:3,
        img: A3,
        headShot:B3,
        uName: "林文彬",
        alt: "小島3.5度-Island Aurora",
        rName: "小島3.5度-Island Aurora",
        teg1: "球池",
        teg2: "沙坑",
        teg3: "溜滑梯",
        teg4: "現金支付",
        teg5: "信用卡",
        fraction: "4.6",
        frequency: "(共333則評價)",
        content:
          "小島3.5度-Island Aurora，位於台中新星之區北屯經貿地段，在一片開發中的重劃區中，獨樹一幟的建築外觀彷彿成為一座世外桃源的小島，簡單的配色加上綠地與門口前的三隻小龍，是個讓人心情愉悅的優閒情景；一樓有大數量的座位與包廂，二樓則是孩童爽快玩樂到不能自己的專屬遊戲區，供應異國美食、咖啡和茶飲，就讓我們跳脫平日的框架，全家一起體會小島的餐點與遊戲魅力吧！",
        message:
          "上次來是3年前，這次來小朋友們玩得很開心 4歲、2歲，都能玩得很盡興！餐點雖然價格高一點 但很好吃是真的，小朋友兒童餐也吃的很滿足！晚上用餐結束要帶孩子上樓玩有先請服務人員幫我們打包飲料、壽星贈送的蛋糕，回家後發現沒有蛋糕 不曉得是不是忘記放～！",
        date: "2023-04-15",
      },
      {
        resturant_id:4,
        img: A4,
        headShot:B4,
        uName: "林淑娟",
        alt: "小樂圓oden good",
        rName: "小樂圓oden good",
        teg1: "球池",
        teg2: "火坑",
        teg3: "爬行專區",
        teg4: "全場消毒",
        teg5: "衛生防護",
        fraction: "4.5",
        frequency: "(共444則評價)",
        content:
          "小樂圓oden good和洋餐食｜主打室內兩層樓高包覆式旋轉溜滑梯與戶外親子大沙坑的親子餐廳，附設軌道車！ 小朋友絕對卯起來玩，放電指數💯，沒有限制身高，大人小孩都可以玩唷！餐點以日式精緻套餐，使用高大鮮奶兒童餐送多美小汽車。",
        message:
          "兩層樓室內的溜滑梯和戶外沙坑池為特色，當天中午用餐室內溫度顯悶熱，餐點份量精緻，餐點為「PRIME牛小排蓋飯」和「田園香草豬火鍋」等，口味一般，飲料價格略高些，整體服務還不錯！建議店家，店內所提供給小孩的玩具需定期清潔，餐廳內有賣小車玩具！",
        date: "2023-03-10",
      },
    ],
  };
  componentDidMount() {
      let cardText = document.getElementsByClassName("card-text");
      // let cardTextnum = document.getElementsByClassName("card-text");
      // console.log(cardTextnum);

      let btn = document.getElementsByClassName("btn-showMore");
      // let card = document.getElementsByClassName("resturant-card");
      let showbyClick = document.getElementsByClassName("showbyClick");
      // console.log(btn);

      for (let i = 0; i < btn.length; i++) {
          btn[i].addEventListener("click", function (event) {
              // console.log("ok");
              cardText[i].setAttribute(
                  "style",
                  "height:auto;overflow:visible;"
              );
              btn[i].setAttribute(
                  "className",
                  "btn btn-primary btn-showMore d-none"
              );
              showbyClick[i].setAttribute("class", "col-md-12 showbyClick");
              // card[i].setAttribute("style", "height:auto;");
              event.target.classList.add("d-none");
          });
      }
  }

  render() {
    return (
      <section>
        <div style={{height:"10vh"}}></div>
        <h3 className="bgtext3"></h3>
        <div className="container mb-3">
          <div className="row align-items-center majorColor rounded-top">
            <div className="col mt-2 ps-5 align-middle text-center h2 text-light fw-bolder letter-spacing10">
              為您推介的精選親子餐廳
            </div>
          </div>
          <div className="row justify-content-center px-2 border rounded-bottom bg-light">
            <div className="restaurant mt-4">
              <div className="container">
                <div className="row">
                  <div className="col-12">
                    {this.state.infos.map((info, index) => {
                      return (
                        <div className="card mb-4 w-100 shadow" key={index}>
                          <div className="row g-0">
                            <div className="col-md-4">
                              <img
                                src={info.img}
                                className="img-fluid rounded-5 p-3 mt-2 ms-2"
                                alt={info.alt}
                              />
                            </div>
                            <div className="col-md-8">
                              <div className="card-body p-3 mt-2">
                                <a className="card-title fw-bold fs-3" href={"http://localhost:3000/storeinformation/" + info.resturant_id} style={{textDecoration:"none"}}>
                                  {info.rName} <small className="fs-6 text-dark ms-3">👈點擊前往</small>
                                </a>
                                <p>
                                  <span className="btn btn-outline-primary me-2">
                                    {info.teg1}
                                  </span>
                                  <span className="btn btn-outline-primary me-2">
                                    {info.teg2}
                                  </span>
                                  <span className="btn btn-outline-primary me-2">
                                    {info.teg3}
                                  </span>
                                  <span className="btn btn-outline-primary me-2">
                                    {info.teg4}
                                  </span>
                                  <span className="btn btn-outline-primary me-2">
                                    {info.teg5}
                                  </span>
                                </p>
                                <p className="fs-4 mb-1">
                                  {info.fraction}
                                  <i className="bi bi-star-fill text-warning ms-2"></i>
                                  <span className="ms-2 fs-6">
                                    {info.frequency}
                                  </span>
                                </p>
                                <p className="card-text fs-5" style={{height: "15vh"}}>{info.content}</p>
                              </div>
                            </div>
                            <div className="d-flex justify-content-center mb-3">
                              <button className="btn btn-light schBtn border border-dark btn-showMore">
                                繼續閱讀
                              </button>
                            </div>
                            <div className="col-md-12 d-none showbyClick">
                              <div className="row bgcTp border border-dark-subtle border-4 rounded-5 ms-4 me-4 mb-4">
                                <h4 className="fw-bold text-center mt-4 mb-3">精選評價</h4>
                                <div className="col-3 row">
                                  <div className="mt-2 ms-3">
                                    <img
                                      src={info.headShot}
                                      className="img-fluid border border-3 rounded-circle mx-auto mb-5 d-block"
                                      style={{width: "50%",height: "90%"}}
                                      alt="/"
                                    />
                                  </div>
                                  <div className="text-center mb-4 ms-3">
                                    {info.uName}
                                  </div>
                                </div>
                                <div className="col-9">
                                  <p className="fs-5">
                                    {info.rName}
                                    {info.message}
                                  </p>
                                  <p>{info.date}</p>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              </div>
            </div>
            <button className="col-10 btn btn-warning border border-dark rounded-pill fw-bold letter-spacing10 my-4 py-2 fs-5">
              查看更多
            </button>
          </div>
        </div>
      </section>
    );
  }
}

export default Infomation;
