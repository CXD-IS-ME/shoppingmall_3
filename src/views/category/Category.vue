<template>
    <div class="container">
      <!-- 分类侧边栏 -->
      <el-aside class="sidebar" :style="{ height: wh + 'px' }">
        <el-menu :default-active="currentCategoryIndex.toString()" @select="onCategoryTap">
          <el-menu-item
            v-for="(category, index) in categories"
            :key="category.CategoryID"
            :index="index.toString()"
          >
            {{ category.CategoryName }}
          </el-menu-item>
        </el-menu>
      </el-aside>
  
      <!-- 商品列表 -->
      <el-main class="content">
        <div v-if="currentCategory.products.length === 0" class="no-products">
          <img src="../../assets/th.jpg" alt="">
          <p class="pno-products">无此类商品</p>
        </div>
        <div v-else class="product-list" v-for="product in currentCategory.products" :key="product.ProductID">
          <el-image class="product-image" :src="baseURL + product.Image" @click="showProductDetail(product)" />
          <div class="product-info">
            <div class="product-name" @click="showProductDetail(product)">{{ product.ProductName }}</div>
            <div class="product-price">¥{{ product.Price }}</div>
          </div>
        </div>
      </el-main>
  
      <!-- 商品详情对话框 -->
      <el-dialog title="商品详情" v-model="dialogVisible" width="30%">
        <div v-if="selectedProduct">
          <img :src="baseURL + selectedProduct.Image" class="detail-image" />
          <h3>{{ selectedProduct.ProductName }}</h3>
          <p>{{ selectedProduct.Description }}</p>
          <p class="product-price">¥{{ selectedProduct.Price }}</p>
          <el-button type="primary" :icon="ShoppingCart" circle plain @click="addToCart(selectedProduct)"></el-button>
        </div>
      </el-dialog>
    </div>
  </template>
  <script setup>
  import { ref, onMounted } from 'vue';
  import { ElAside, ElMenu, ElMenuItem, ElMain, ElImage, ElDialog, ElButton, ElMessage } from 'element-plus';
  import {
    ShoppingCart

} from '@element-plus/icons-vue'
  import axios from 'axios';
  import { useCartStore } from '@/stores/cart';
  const currentCategory = ref({
    products: []
  });
  const categories = ref([]); // 用于存储从接口获取的分类数据
  const currentCategoryIndex = ref(0); // 当前选中的分类索引
  const baseURL = 'http://phptest.com:8080'; // 图片基础URL
  const wh = ref(0); // 窗口高度
  const dialogVisible = ref(false); // 对话框可见性
  const selectedProduct = ref(null); // 选中的商品
  
  onMounted(() => {
    fetchCategories();
    wh.value = window.innerHeight; // 设置窗口高度
  });
  
  const fetchCategories = async () => {
    try {
      const response = await axios.get(`${baseURL}/categories`);
      if (response.status === 200 && response.data && response.data.code === 200) {
        categories.value = response.data.data.data;
        currentCategory.value = categories.value[0] || { products: [] }; // 初始化时，设置当前分类为第一个分类
      } else {
        console.error('获取分类数据失败:', response.data.msg || '未知错误');
      }
    } catch (error) {
      console.error('请求失败:', error);
    }
  };
  
  const onCategoryTap = (index) => {
    currentCategoryIndex.value = parseInt(index, 10);
    currentCategory.value = categories.value[currentCategoryIndex.value]; // 更新当前选中的分类数据
  };
  
  const showProductDetail = (product) => {
    selectedProduct.value = product;
    dialogVisible.value = true; // 显示对话框
  };
  const cartStore = useCartStore();
  const selectedProducts = ref([]);
  const addToCart = (product) => {
    cartStore.addToCart(product);
    selectedProducts.value.push(product);
    ElMessage({
      message: '添加成功',
      type: 'success',
    });
    dialogVisible.value = false;
  };
  </script>
  <style>
  .container {
  display: flex;
  height: 100vh;
}

.sidebar {
  width: 200px;
  background-color: #f7f7f7;
  height: 100vh;
}

.content {
  flex: 1;
  background-color: #fff;
  overflow-y: auto;
}
.pno-products{
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: rgba(111, 202, 230, 0.5); /* 半透明背景 */
  color: #ac8d8d;
  padding: 20px;
  border-radius: 10px; /* 圆角边框 */
  font-size: 16px;
  text-align: center;
  z-index: 10;
}
.no-products {
  text-align: center;
  padding: 20px;
  color: #999;
  font-size: 16px;
}

.product-list {
  display: flex;
  align-items: center;
  padding: 20px;
  border-bottom: 1px solid #eee;
}

.product-image {
  width: 120px;
  height: 120px;
  margin-right: 20px;
  border-radius: 10px;
}

.product-info {
  flex: 1;
}

.product-name {
  color: #333;
  font-size: 16px;
}

.product-price {
  color: #f00;
  font-size: 14px;
  margin-top: 10px;
}
.detail-image {
  width: 100%;
  height: auto;
  margin-bottom: 20px;
}
</style>