<template>
    <div>
      <el-container>
        <el-header> 
          <myheader></myheader>
        </el-header>
        <el-container>
            <el-aside width="200px">
            <myaside></myaside>
            </el-aside>
              <el-main>
                <router-link to="/"></router-link>
                <router-view></router-view>
            </el-main>
        </el-container>
      </el-container>
          
    </div>

</template>

<script>
    import myheader from '../Container/My-header.vue';
    import myaside from '../Container/My-aside.vue';

    export default {
        components: {
            myheader,
            myaside,
        },
        data() {
            return {
                msg: 'Hello Vue!'
            }
        }
    }
</script>

<style>

.el-main {
  background-color: #fff;
  color: #333;
}

</style>