<template>
	<button @click="click">
		<slot />
	</button>
</template>

<script>
export default {
	props: {
		click: {
			type: Function,
			required: true
		}
	}
}
</script>

<style scoped lang="scss">
@import '../../../../assets/stylesheets/vars';

button {
	border: 2px solid $darkGray;
	padding: .5rem;
	font-family: inherit;
	font-size: 1rem;
	border-radius: .25rem;
}
</style>


