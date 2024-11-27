<template>

    <div>
        <el-divider content-position="left">
            <h3>申请记录</h3>
        </el-divider>
        <br>

        <!-- 搜索框 -->
        <!-- 筛选 -->

        <el-select v-model="q.applyStatus" placeholder="选择审批状态" popper-class="custom-popper" style="margin-left: 50px;">
            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
        </el-select>


        <br>
        <el-divider></el-divider>

        <!-- 可用设备表格 -->
        <el-table :data="tableData" style="width: 100%">
            <el-table-column prop="applyId" label="审批编号" width="250" align="center">
            </el-table-column>
            <el-table-column prop="chargeId" label="设备编号" width="250" align="center">
            </el-table-column>
            <el-table-column prop="applyTime" label="申请时间" width="300" align="center">
            </el-table-column>
            <el-table-column prop="applyStatus" label="审批状态" width="250" align="center">
            </el-table-column>
            <el-table-column prop="applicant" label="申请人" width="250" align="center">
            </el-table-column>
        </el-table>
        <br>
        <el-divider>
        </el-divider>
        <!-- 分页 -->
        <div style="display: flex; justify-content: center; margin: 20px 0;">
            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
                :page-sizes="[10, 20, 30, 40]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper"
                :total="total">
            </el-pagination>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    mounted() {
        this.getData()
    },
    data() {
        return {
            tableData: {},
            pageNum: 1,
            pageSize: 10,
            total: 0,
            applyId: '',
            chargeId: '',
            applyTime: '',
            applyStatus: '',
            applicant: '',
            q: {
                applyStatus: '',
            },
            options: [{
                value: '已完成',
                label: '已完成'
            },
            {
                value: '审批中',
                label: '审批中'
            },
            {
                value: '未通过',
                label: '未通过'
            }
            ]
        }
    },
    watch: {
        'q.applyStatus': function (newValue) {
            this.queryDan(newValue);
        }
    },
    methods: {
        // 分页查询
        getData() {
            axios.get(`${process.env.VUE_APP_API_URL}/apply/getByPage1`, {
                params: {
                    pageNum: this.pageNum,
                    pageSize: this.pageSize,
                    applicant: localStorage.getItem('userId')
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
        //分页
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
        //单选查询
        queryDan() {
            axios.get(`${process.env.VUE_APP_API_URL}/apply/getByApplyStatus1`, {
                params: {
                    applyStatus: this.q.applyStatus,
                    applicant: localStorage.getItem('userId')
                }
            }).then(res => {
                console.log(res.data);
                this.tableData = res.data;
            })
        },
    }



}



</script>