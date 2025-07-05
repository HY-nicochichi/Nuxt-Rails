<script setup lang="ts">
  import NavBar from '~/components/NavBar.vue'
</script>


<template>
  <div class="text-white">
    <NuxtLoadingIndicator
      color="deepskyblue" :height="5"
    />
    <NavBar/>
    <div class="p-3">
      <NuxtPage/>
    </div>
  </div>
</template>


<style>
  body {background-color:rgb(50,0,0)}
</style>
