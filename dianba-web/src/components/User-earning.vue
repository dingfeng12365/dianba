<template>
  <div id="app">
    <el-container>
      <el-header>
        <div class="header-content">
          <span>充电桩收益</span>
          <el-button type="primary" @click="exitApp">
            <router-link to="/info">退出</router-link>
          </el-button>
        </div>
      </el-header>
      <el-main>
        <div class="main-container">
          <div class="left-top"> <!-- 左上区域的内容 -->
            <h3>总耗电量</h3>
            <p>{{ totalPowerConsumption }} kWh</p>
          </div>

          <div class="left-bottom"> <!-- 左下区域的内容 -->
            <h3>总收益</h3>
            <p>{{ totalRevenue }} 元</p>
          </div>
          <div class="right-top"> <!-- 右上区域的内容 -->
            <h3>租用费用</h3>
            <p>{{ rentalFee }} 元</p>
          </div>
          <div class="right-bottom"> <!-- 右下区域的内容 -->
            <h3>净利润</h3>
            <p>{{ netProfit }} 元</p>
          </div>
        </div>
      </el-main> <el-footer> <!-- 在这里添加页脚内容 --> </el-footer> </el-container>
  </div>
</template>
<script>
import axios from 'axios';
export default
  {
    name: 'App',
    data() {
      return {
        totalPowerConsumption: 0,//总耗电量
        totalRevenue: 0,//总收益
        rentalFee: 0,//租用费用
        netProfit: 0,//净利润
        equipNumber: 0,//设备数量
        showExitButton: false
      };
    },
    mounted() {
      // 在组件挂载后获取初始数据  
      this.fetchData();
      this.showAll();
      // 每隔 10 秒更新一次数据  
      this.interval = setInterval(this.fetchData, 3000);
      this.interval = setInterval(this.showAll, 3000);

    },
    beforeDestroy() {
      // 在组件销毁前清除定时器  
      clearInterval(this.interval);
    },
    methods: {
      fetchData() {
        // 根据本地存储的userId从后端获取该用户所属设备的并计算总耗电量  
        axios.get(`${process.env.VUE_APP_API_URL}/charge/getTotalPowerConsumption`, {
          params: {
            owningId: localStorage.getItem('userId')
          }
        }).then(res => {
          // 假设res.data是一个数组，每个元素都是一个对象，每个对象都有一个powerConsumption属性  
          if (Array.isArray(res.data)) {
            this.equipNumber = res.data.length;
            // console.log(res.data);
            // 使用reduce方法来累加每个元素的powerConsumption  
            this.totalPowerConsumption = res.data.reduce((accumulator, currentValue) => {
              // 假设currentValue.powerConsumption存在且是数值类型  
              if (typeof currentValue.powerConsumption === 'number') {
                return accumulator + currentValue.powerConsumption;
              }
              // 如果powerConsumption不是数值类型，则不加入累加  
              return accumulator;
            }, 0); // 第二个参数是累加器的初始值，这里初始化为0  

            // console.log(this.totalPowerConsumption); // 输出总耗电量  
          } else {
            console.error('数据格式不正确，不是数组');
          }
        }).catch(error => {
          console.error('请求出错:', error);
        });
      },
      exitApp() {
        // 在这里添加退出逻辑,如关闭页面或跳转到其他页面  
        console.log('关闭页面');
      },
      //显示总耗电量，总收益，租用费用，净利润
      showAll(){
        //总收益为耗电量*1.25
        this.totalRevenue = this.totalPowerConsumption * 1.25;
        //租用费用为设备数*2000
        this.rentalFee = this.equipNumber * 2000;
        //净利润为总收益减租用费用
        this.netProfit = this.totalRevenue - this.rentalFee;
      }
    }

  } </script>
<style scoped>  
html,  
body {  
  height: 100%;  
  margin: 0;  
  overflow: hidden;  
}  

.el-container {  
  height: 100vh;  
  display: flex;  
  flex-direction: column;  
  background-image: url('../assets/个人收益背景图.png'); /* 设置背景图 */  
  background-size: cover; /* 确保背景图覆盖整个容器 */  
  background-position: center; /* 将背景图居中 */  
}  

.el-header,  
.el-footer {  
  background-color: rgba(179, 192, 209, 0.8); /* 可以设置透明度或其他颜色 */  
  color: #333;  
  text-align: center;  
  line-height: 60px;  
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);  
}  

.el-main {  
  background-color: rgba(233, 238, 243, 0.8); /* 设置透明度的主背景 */  
  color: #333;  
  text-align: center;  
  flex-grow: 1;  
  display: flex;  
  flex-direction: column;  
  justify-content: center;  
  align-items: center;  
  position: relative;  
}  

.main-container {  
  display: grid;  
  grid-template-columns: repeat(2, 1fr);  
  grid-template-rows: repeat(2, 1fr);  
  grid-gap: 30px;  
  width: 90%;  
  height: 90%; 
}  

.left-top,  
.left-bottom,  
.right-top,  
.right-bottom {  
  background-color: rgba(255, 255, 255, 0.9); /* 设置卡片背景为半透明以便看到背景图 */  
  border-radius: 5px;  
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);  
  padding: 30px;  
  display: flex;  
  flex-direction: column;  
  justify-content: center;  
  align-items: center;  
}  

.left-top:hover,  
.left-bottom:hover,  
.right-top:hover,  
.right-bottom:hover {  
  transform: scale(1.05);  
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);  
}  

.header-content {  
  display: flex;  
  justify-content: space-between;  
  align-items: center;  
}  

.header-content button {  
  margin-left: auto;  
  background-color: #2d9ae7;  
  color: #fff;  
  border: none;  
  padding: 10px 20px;  
  border-radius: 5px;  
  cursor: pointer;  
  transition: background-color 0.3s ease;  
}  
</style>