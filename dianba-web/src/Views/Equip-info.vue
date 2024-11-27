<template>
  <div>
    <div>
      <el-divider content-position="center">
        <h2>设备管理</h2>
      </el-divider>
      <el-divider content-position="left">
        <h3>设备信息查询</h3>
      </el-divider>
      <br />
      <!-- 输入框搜索 -->
      <div style="display: flex; align-items: center;">
        <el-input placeholder="请输入拥有者编号" prefix-icon="el-icon-search" v-model="owningId"
          style="width: 300px; margin-left: 70px; margin-right: 10px;"> <!-- Adjusted margin-left -->
        </el-input>
        <el-button @click="query()" type="primary" icon="el-icon-search">搜索</el-button>

        <!-- 筛选 -->

        <el-select v-model="q.zhuangTai" placeholder="选择状态" popper-class="custom-popper" style="margin-left: 50px;">
          <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
        </el-select>


        <!-- 增加 -->
        <el-button @click="dialogVisible2 = true" type="primary" icon="el-icon-edit"
          style="margin-left: 400px;">增加设备</el-button>
      </div>
      <br />

      <el-divider content-position="left">
        <h3>设备信息</h3>
      </el-divider>
    </div>


    <!-- 表格 -->

    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="chargeId" label="设备编号" width="100" align="center">
      </el-table-column>
      <el-table-column prop="chargeName" label="设备名称" width="150" align="center">
      </el-table-column>
      <el-table-column prop="position" label="设备地址" width="300" align="center">
      </el-table-column>
      <el-table-column prop="launch" label="使用状态" width="100">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.launch" active-color="#13ce66" inactive-color="#ff4949">
          </el-switch>
        </template>
      </el-table-column>
      <el-table-column prop="zhuangTai" label="设备情况" width="150" align="center">
      </el-table-column>
      <el-table-column prop="owningId" label="拥有者ID" width="150" align="center">
      </el-table-column>
      <!-- <el-table-column prop="maintenanceTime" label="维护时间" width="200">
        <template slot-scope="scope">
          <i class="el-icon-time"></i>
          <span style="margin-left: 10px">{{ scope.row.date }}</span>
        </template>
      </el-table-column> -->
      <el-table-column prop="maintenanceTime" label="维护时间" width="200" align="center">
      </el-table-column>
      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
          <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div style="display: flex; justify-content: center; margin: 20px 0;">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
        :page-sizes="[10, 20, 30, 40]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
        :total="total">
      </el-pagination>
    </div>

    <!-- 添加弹窗 -->

    <el-dialog title="增加设备" :visible.sync="dialogVisible2" width="30%" :before-close="handleClose">
      <span>
        <el-form ref="form1" :model="form1" label-width="80px">
          <el-form-item label="设备名称">
            <el-input v-model="form1.chargeName"></el-input>
          </el-form-item>
          <el-form-item label="设备地址">
            <el-input v-model="form1.position"></el-input>
          </el-form-item>
          <el-form-item label="使用状态">
            <el-switch v-model="form1.launch" active-color="#13ce66" inactive-color="#ff4949">
            </el-switch>
          </el-form-item>
          <el-form-item label="设备情况">
            <el-select v-model="form1.zhuangTai" placeholder="请选择">
              <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="维护时间">
            <el-date-picker v-model="form1.maintenanceTime" align="right" type="date" placeholder="选择日期"
              :picker-options="pickerOptions">
            </el-date-picker>
          </el-form-item>
        </el-form>
      </span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible2 = false">取消</el-button>
        <el-button type="primary" @click="add()">确 定</el-button>
      </span>
    </el-dialog>

    <!-- 编辑弹窗 -->
    <el-dialog title="信息编辑" :visible.sync="dialogVisible1" width="30%" :before-close="handleClose">
      <span>
        <el-form ref="form" :model="form" label-width="80px">
          <el-form-item label="设备名称">
            <el-input :disabled="true" v-model="form.chargeName"></el-input>
          </el-form-item>
          <el-form-item label="设备地址">
            <el-input v-model="form.position"></el-input>
          </el-form-item>
          <el-form-item label="使用状态">
            <el-switch v-model="form.launch" active-color="#13ce66" inactive-color="#ff4949">
            </el-switch>
          </el-form-item>
          <el-form-item label="设备情况">
            <el-select v-model="form.zhuangTai" placeholder="请选择">
              <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="拥有者ID">
            <el-input v-model="form.owningId"></el-input>
          </el-form-item>
          <el-form-item label="维护时间">
            <el-date-picker v-model="value2" align="right" type="date" placeholder="选择日期"
              :picker-options="pickerOptions">
            </el-date-picker>
          </el-form-item>
        </el-form>
      </span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible1 = false">取消</el-button>
        <el-button type="primary" @click="update()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      tableData: {},
      value: true,
      /* 编辑 */
      dialogVisible1: false,
      /* 添加  */
      dialogVisible2: false,
      pageNum: 1,
      pageSize: 10,
      total: 0,

      chargeId: '',
      chargeName: '',
      position: '',
      launch: '',
      zhuangTai: '',
      owningId: '',
      maintenanceTime: '',
      q: {
        zhuangTai: '',
      },
      value2: '',
      options: [{
        value: '正常',
        label: '正常'
      },
      {
        value: '异常',
        label: '异常'
      }
      ]
      ,
      form: {
        chargeId: '',
        chargeName: '',
        position: '',
        launch: '',
        zhuangTai: '',
        owningId: '',
         maintenanceTime: ''
      }
      ,
      form1: {
        chargeId: '',
        chargeName: '',
        position: '',
        launch: true,
        zhuangTai: '',
        maintenanceTime: '',
        cost: 2000,
        owningId: 0,
        powerConsumption:0,
      },
      
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now();
        },
        shortcuts: [{
          text: '今天',
          onClick(picker) {
            picker.$emit('pick', new Date());
          }
        }, {
          text: '昨天',
          onClick(picker) {
            const date = new Date();
            date.setTime(date.getTime() - 3600 * 1000 * 24);
            picker.$emit('pick', date);
          }
        }, {
          text: '一周前',
          onClick(picker) {
            const date = new Date();
            date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
            picker.$emit('pick', date);
          }
        }]
      },

    }
  }
  ,
  watch: {  
    'q.zhuangTai': function(newValue) {  
      this.queryDan(newValue);  
    },
  },
  methods: {
    /* 获取数据 */
    getData() {
      axios.get(`${process.env.VUE_APP_API_URL}/charge/getByPage`, {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data.records;
        // console.log(res.data.records);
        // console.log(this.tableData);
        this.total = res.data.total;
        this.pageNum = res.data.current;
        this.pageSize = res.data.size;
      })
    },
    /* 查询 */
    query() {
      axios.get(`${process.env.VUE_APP_API_URL}/charge/getByOwningId`, {
        params: {
          owningId: this.owningId
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data;
      })
    },
    queryDan() {
      axios.get(`${process.env.VUE_APP_API_URL}/charge/getByZhuangTai`, {
        params: {
          zhuangTai: this.q.zhuangTai
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data;
      })
    },
    
    /* 分页 */
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
      this.pageSize = val;
      this.getData();
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
      this.pageNum = val;
      this.getData();
    },
    /* 编辑 */
    handleEdit(index, row) {
      console.log(index, row);
      this.dialogVisible1 = true;
      this.form = row;
    },
    /* 删除 */
    handleDelete(index, row) {
      console.log(index, row);
      axios.get(`${process.env.VUE_APP_API_URL}/charge/delByChargeId`, {
        params: {
          chargeId: row.chargeId
        }
      }).then(res => {
        console.log(res.data);
        //刷新数据
        this.getData();
      })
    },
    /* 关闭弹窗 */
    handleClose() {
      this.dialogVisible1 = false;
      this.dialogVisible2 = false;
    },
    /* 更新 */
    update() {
      axios.post(`${process.env.VUE_APP_API_URL}/charge/update`, this.form)
        .then(res => {
          console.log(res);
        })
        .catch(error => {
          console.log(error);
        });
      this.dialogVisible1 = false;
    },
    /* 增加数据 */
    add() {

      console.log(this.form1);
      axios.post(`${process.env.VUE_APP_API_URL}/charge/add`, this.form1)
        .then(res => {
          console.log(res);
          this.getData();
        })
        .catch(error => {
          console.log(error);
        });
      this.dialogVisible2 = false;
    }

  },
  mounted() {
    this.getData()
  }
}

</script>

<style></style>