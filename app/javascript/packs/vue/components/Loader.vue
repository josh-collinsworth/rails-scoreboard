<template>
	<div id="loader">
		<h1>Loading…</h1>
	</div>
</template>


<script>
export default {

}
</script>


<style scoped lang="scss">
@import '../../../../assets/stylesheets/vars';

	#loader {
		width: 100vw;
		height: 100vh;
		position: fixed;
		display: flex;
		align-items: center;
		justify-content: center;
		background: $lightBlue;
		top: 0;
		left: 0;
		color: $white;
	}
</style>
