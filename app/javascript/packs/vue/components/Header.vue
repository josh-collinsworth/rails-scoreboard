<template>
	<header>
		<a href="/">Back to Game list</a>
		<h1>{{ game.name }} </h1>
		<Button :click="toggleOptions">Menu</Button>
		<Options :menuOpen="menuOpen" :game="game" />
	</header>
</template>


<script>
import Button from './Button'
import Options from './Options'

export default {
	name: 'Header',
	data: () => ({
		menuOpen: false
	}),
	components: {
		Button, Options
	},
	props: {
		game: {
			type: Object,
			required: true
		}
	},
	methods: {
		toggleOptions() {
			this.menuOpen = !this.menuOpen;
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
		padding: .75rem;
		height: 4rem;

		h1 {
			margin: 0;
		}
	}
</style>
