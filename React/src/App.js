import React from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap/dist/js/bootstrap.js";

// index
import "./components/css/index.css";
import Index from "./components/index/Index";

//Enterprise
import Enterprise from "./components/enterprise/Enterprise";

//member
import MemberMain from "./components/member/MemberMain";
import "./components/css/member.css";

//Search
import SearchIndex from "./components/search/SearchIndex";
import Page2 from "./components/index/test";

//admin
import Admin from "./components/admin/adminNew";
import StoreInformation from "./components/admin/storeinformation.jsx";
import Forget from "./components/admin/forget";
import ResetPwd from "./components/admin/resetPwd";
import OpenStore from "./components/admin/openStore";
import Login from "./components/admin/login_Roy";
import Register from "./components/admin/register_Roy";
import ResetStore from "./components/admin/resetStore";


const App = () => {
  return (
    <BrowserRouter>
      <Switch>
        {/* index */}
        <Route path="/" component={Index} exact/>
        <Route path="/index" component={Index} />
        {/* Enterprise */}
        <Route path="/enterprise" component={Enterprise} />
        {/* member */}
        <Route path="/membermain" component={MemberMain} />
        {/* Search */}
        <Route path="/test" component={Page2}></Route>
        <Route path="/searchIndex" component={SearchIndex}></Route>
        {/* admin */}
        <Route path="/storeinformation/:resId" component={StoreInformation} />
        <Route path="/admin" component={Admin} />
        <Route path="/login" component={Login} />
        <Route path="/register" component={Register} />
        <Route path="/forget" component={Forget} />
        <Route path="/resetPwd/:token/:id" component={ResetPwd} />
        <Route path="/resetStore/:token/:id" component={ResetStore} />
        <Route path="/openStore/:token/:account" component={OpenStore} />
      </Switch>
    </BrowserRouter>
  );
};

export default App;
