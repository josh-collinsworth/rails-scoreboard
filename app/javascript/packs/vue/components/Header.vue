<template>
	<header>
		<Button :click="newGame">New Game</Button>
		<Button :click="itWorks">Add team</Button>
	</header>
</template>


<script>
import Button from './Button'

export default {
	name: 'Header',
	components: {
		Button
	},
	methods: {
		itWorks() {
			console.log('It works!');
		},
		newGame() {
			console.log('NEW GAME (COME BACK TO ME LATER)')
		}
	}
}
</script>


<style scoped lang="scss">
	@import '../../../../assets/stylesheets/vars';

	header {
		display: flex;
		align-items: center;
		justify-content: space-between;
		background: $lightBlue;
		padding: 12px;
	}
</style>
