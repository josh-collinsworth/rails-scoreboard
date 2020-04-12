<template>
	<header v-if="game">
		<a href="/">Back to Game list</a>
		<h1>{{ game.name }} </h1>
		<div>
			<button @click="togglePlayerMenu">Players</button>
			<button @click="toggleOptionsMenu">Game Options</button>
		</div>
		<Players :player-menu-open="playerMenuOpen" :game="game" :refresh="refresh" :players="players" />
		<Options :options-menu-open="optionsMenuOpen" :game="game" :refresh="refresh" />
	</header>
</template>


<script>
import Options from './Options'
import Players from './Players'

export default {
	name: 'Header',
	data: () => ({
		optionsMenuOpen: false,
		playerMenuOpen: false
	}),
	components: {
		Options, Players
	},
	props: {
		game: {
			type: Object,
			required: true
		},
		refresh: {
			type: Function,
			required: true
		},
		players: {
			type: Array,
			required: true
		}
	},
	methods: {
		toggleOptionsMenu () {
			this.playerMenuOpen = false
			this.optionsMenuOpen = !this.optionsMenuOpen
		},
		togglePlayerMenu () {
			this.playerMenuOpen = !this.playerMenuOpen
			this.optionsMenuOpen = false
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
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;

		h1 {
			margin: 0;
		}

		button {
			margin: 0 0 0 .5rem;
		}
	}
</style>
