
import VueRouter from "vue-router";

const routes =[
  

  {
    path: "/",
    name: "zhuye",
    component: () => import('../components/User-zhuye.vue'),
  },
  {
    path: "/zhuye",
    name: "zhuye",
    component: () => import('../components/User-zhuye.vue'),
    meta:{isAuthenticated:true,roleId:['1','3']},
  },
  {
    path: "/tumb",
  name: "tumb",
  component: () => import('../presentation/Tumbrel.vue'),
  },

  {
    path: "/auto",
  name: "auto",
  component: () => import('../presentation/Auto-mobile.vue'),
  },
  {
    path: "/intro",
  name: "intro",
  component: () => import('../presentation/Introduction.vue'),
  },
  
  {
    path: "/glory",
  name: "glory",
  component: () => import('../presentation/Glories.vue'),
  },
    {
      // 个人主页，普通用户和管理人员均可访问，roleId为1或3
      path: "/info",
      name: "info",
      component: () => import('../components/User-information.vue'),
      meta:{isAuthenticated:true,roleId:['1','3']},
    
    },
      {
      path: "/apply",
      name: "apply",
      component: () => import('../components/User-apply.vue'),
      meta:{isAuthenticated:true,roleId:['1','3']},
      children: [
        {
          path: "",
          name: "serviceable",
          component: () => import('../Views/Serviceable-equip.vue'),
          meta:{isAuthenticated:true,roleId:['1','3']},
        },
        {
          path: "/serviceable",
          name: "serviceable",
          component: () => import('../Views/Serviceable-equip.vue'),
          meta:{isAuthenticated:true,roleId:['1','3']},
        },
        {
          path: "/record",
          name: "record",
          component: () => import('../Views/Record-apply.vue'),
          meta:{isAuthenticated:true,roleId:['1','3']},
        },
      ]
      },
    {
      path: "/earning",
      name: "earning",
      component: () => import('../components/User-earning.vue'),
      meta:{isAuthenticated:true,roleId:['1','3']},
    },
  
    {
      path: "/manage",
      name: "manage",
      component: () => import('../components/User-manage.vue'),
      //需要已经登录并且是管理员才能访问
      meta:{isAuthenticated:true,roleId:['3']},

      children: [

        {
          path: "/",
          name: "equip",
          component: () => import('../Views/Equip-info.vue'),
          meta:{isAuthenticated:true,roleId:['3']},
        },
        {
          path: "/equip",
          name: "equip",
          component: () => import('../Views/Equip-info.vue'),
          meta:{isAuthenticated:true,roleId:['3']},
        },
        {
          path: "/maintenance",
          name: "maintenance",
          component: () => import('../Views/Maintenance-log.vue'),
          meta:{isAuthenticated:true,roleId:['3']},
        },
       
        
        {
          path: "/serinfo",
          name: "serinfo",
          component: () => import('../Views/Service-info.vue'),
          meta:{isAuthenticated:true,roleId:['3']},
        },
        
        {
          path: "/userinfo",
          name: "userinfo",
          component: () => import('../Views/User-info.vue'),
          meta:{isAuthenticated:true,roleId:['3']},
        },
        {
          path: "/approve",
          name: "approve",
          component: () => import('../Views/Approve-apply.vue'),
          meta:{isAuthenticated:true,roleId:['3']},
        },
        
      ]
    },
    
    
];

const router = new VueRouter({
  mode: "history",
  routes,
});

//添加路由守卫
router.beforeEach((to, from, next) => {
  //让首页不受影响
  if (to.path == "/" || to.path == "/tumb" || to.path == "/intro" || to.path == "/glory" || to.path == "/auto") {
    next();
    return;
  }
  //判断是否已经登录
  if (localStorage.getItem("isAuthenticated")) {

    // console.log(localStorage.getItem("isAuthenticated"));
    // console.log(localStorage.getItem("roleId"));
    const confirmRoleId = localStorage.getItem("roleId");  //1 //3
    

    // console.log(to.meta.roleId);
    //判断是否是管理员
    if (to.meta.roleId.includes(confirmRoleId)) {
      next();
    } else {
      alert("权限不足");
      next({
       path: "/",
      })
    }
  }else{
    alert("请先登录");
    next({
      path: "/",
    });
  }

})


export default router;