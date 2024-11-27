<template>
  <div>
    <div>
      <el-divider content-position="center">
        <h2>设备管理</h2>
      </el-divider>

      <el-divider content-position="left">
        <h3>维护信息查询</h3>
      </el-divider>
      <br />
      <!-- 输入框 -->
      <div style="display: flex; align-items: center;">
        <el-input placeholder="负责人" prefix-icon="el-icon-search" v-model="pchargeId"
          style="width: 300px; margin-left: 70px; margin-right: 10px;"> <!-- Adjusted margin-left -->
        </el-input>
        <el-button @click="query()" type="primary" icon="el-icon-search">搜索</el-button>

        <!-- 筛选 -->

        <el-select v-model="q.done" placeholder="选择完成状态" popper-class="custom-popper" style="margin-left: 50px;">
          <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
        </el-select>

        <!-- 增加数据 -->
        <el-button @click="dialogVisible3 = true" type="primary" icon="el-icon-edit" style="margin-left: 400px;">增加日志
        </el-button>
      </div>
      <br />


      <el-divider content-position="left">
        <h3>维修日志</h3>
      </el-divider>
    </div>

    <!-- 表格 -->
    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="chargeId" label="设备编号" width="100" align="center">
      </el-table-column>
      <el-table-column prop="keepTime" label="维护时间" width="200" align="center">
      </el-table-column>
      <el-table-column prop="pchargeId" label="负责人" width="100" align="center">
      </el-table-column>
      <el-table-column prop="faultDescription" label="故障描述" width="000" align="center">
      </el-table-column>
      <el-table-column prop="done" label="完成状态" width="200" align="center">
      </el-table-column>
      <el-table-column label="更改完成状态">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
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

    <!-- 插入弹窗 -->
    <el-dialog title="增加设备" :visible.sync="dialogVisible3" width="30%" :before-close="handleClose">
      <span>
        <el-form ref="form1" :model="form1" label-width="80px">
          <el-form-item label="设备编号">
            <el-input v-model="form1.chargeId"></el-input>
          </el-form-item>
          <el-form-item label="负责人编号">
            <el-input v-model="form1.pchargeId"></el-input>
          </el-form-item>
          <el-form-item label="维护时间">
            <el-date-picker v-model="form1.keepTime" align="right" type="date" placeholder="选择日期"
              :picker-options="pickerOptions">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="故障描述">
            <el-input v-model="form1.faultDescription"></el-input>
          </el-form-item>
          <el-form-item label="完成状态">
            <el-select v-model="form1.done" placeholder="请选择">
              <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
      </span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible3 = false">取消</el-button>
        <el-button type="primary" @click="add()">确 定</el-button>
      </span>
    </el-dialog>

    <!-- 编辑弹窗 -->
    <el-dialog title="编辑信息" :visible.sync="dialogVisible4" width="30%" :before-close="handleClose">
      <span>
        <el-form ref="form" :model="form" label-width="80px">
          <el-form-item label="设备编号">
            <el-input :disabled="true" v-model="form.chargeId"></el-input>
          </el-form-item>
          <el-form-item label="负责人编号">
            <el-input :disabled="true" v-model="form.pchargeId"></el-input>
          </el-form-item>
          <el-form-item label="维护时间">
            <el-input :disabled="true" v-model="form.keepId"></el-input>
          </el-form-item>
          <el-form-item label="故障描述">
            <el-input  v-model="form.faultDescription"></el-input>
          </el-form-item>
          <el-form-item label="完成状态">
            <el-select v-model="form.done" placeholder="请选择">
              <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
      </span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible4 = false">取消</el-button>
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
      pageNum: 1,
      pageSize: 10,
      total: 0,
      /* 插入的 */
      dialogVisible3: false,
      /* 编辑的 */
      dialogVisible4: false,

      keepId: '',
      chargeId: '',
      chargeName: '',
      pchargeId: '',
      faultDescription: '',
      done: '',
      keepTime: '',
      q: {
        done: '',
      },
      form: {
        keepId: '',
        chargeId: '',
        chargeName: '',
        pchargeId: '',
        faultDescription: '',
        done: '',
        keepTime: '',
      },
      form1: {
        keepId: '',
        chargeId: '',
        chargeName: '',
        pchargeId: '',
        faultDescription: '',
        done: '',
        keepTime: '',
      },
      options: [{
        value: '完成',
        label: '完成'
      },
      {
        value: '未完成',
        label: '未完成',
      }
      ],

    }
  },
  watch: {
    'q.done': function (newValue) {
      this.queryDan(newValue);
    }
  },
  methods: {
    /* 编辑 */
    handleEdit(index, row) {
      console.log(index, row);
      this.dialogVisible4 = true;
      this.form = row;
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
    /* 获取数据 */
    getData() {
      axios.get(`${process.env.VUE_APP_API_URL}/keeplist/getByPage`, {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data.records;
        this.total = res.data.total;
      })
    },
    /* 添加 */
    add() {
      axios.post(`${process.env.VUE_APP_API_URL}/keeplist/add`, this.form1)
        .then(res => {
          console.log(res);
          this.getData();
        })
        .catch(error => {
          console.log(error);
        });
      this.dialogVisible3 = false;
    },
    /*   更新 */
    update() {
      axios.post(`${process.env.VUE_APP_API_URL}/keeplist/update`, this.form)
        .then(res => {
          console.log(res);
        })
        .catch(error => {
          console.log(error);
        });
      this.dialogVisible4 = false;
    },
    /* 查询 */
    query() {
      axios.get(`${process.env.VUE_APP_API_URL}/keeplist/getByPchargeId`, {
        params: {
          pchargeId: this.pchargeId
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data;
      })
    },
    queryDan() {
      axios.get(`${process.env.VUE_APP_API_URL}/keeplist/getByDone`, {
        params: {
          done: this.q.done
        }
      }).then(res => {
        console.log(res.data);
        this.tableData = res.data;
      })
    },
    handleClose() {
      this.dialogVisible3 = false;
      this.dialogVisible4 = false;
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
  },
  mounted() {
    this.getData()
  }
}



</script>