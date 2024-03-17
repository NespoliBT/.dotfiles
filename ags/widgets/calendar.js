export const Calendar = () => Widget.Calendar({
    showDayNames: true,
    showDetails: true,
    showHeading: true,
    showWeekNumbers: true,
    detail: (self, y, m, d) => {
        return `<span color="white">${y}. ${m}. ${d}.</span>`
    },
    onDaySelected: ({ date: [y, m, d] }) => {
        print(`${y}. ${m}. ${d}.`)
    },
})