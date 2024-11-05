//
//  CalendarBuilder+Init.swift
//
//
//  Created by Metin Tarık Kiki on 31.10.2024.
//

import SwiftUI

public typealias DefaultDayContent = BaseCalendarDayView
public typealias DefaultMonthContent = BaseCalendarMonthView<OBCollectionView<_ConditionalContent<BaseCalendarDayView, _ConditionalContent<BaseCalendarDayView, Color>>, CalendarModel.Day>>
public typealias DefaultYearContent = BaseCalendarYearView<OBCollectionView<BaseCalendarMonthView<OBCollectionView<_ConditionalContent<BaseCalendarDayView, _ConditionalContent<BaseCalendarDayView, Color>>, CalendarModel.Day>>, CalendarModel.Month>>

public extension OBBaseCalendar
where DayContent == DefaultDayContent,
      MonthContent == DefaultMonthContent,
      YearContent == DefaultYearContent
{
    init(
        startDate: Date = Date(),
        yearLimit: Int = 1,
        calendar: Calendar,
        scrollTrigger: Binding<ScrollIdType?>,
        includeBlanks: Bool = false,
        lazyYears: Bool = false,
        lazyMonths: Bool = false,
        dayScrollEnabled: Bool = false,
        dayScrollAxis: Axis.Set = .vertical,
        dayGridItems: [GridItem] = Array(0..<7).map { _ in .init(spacing: .zero) }, // 7 day columns by default
        monthScrollEnabled: Bool = false,
        monthScrollAxis: Axis.Set = .vertical,
        monthGridItems: [GridItem] = [.init()],
        yearScrollEnabled: Bool = true,
        yearScrollAxis: Axis.Set = .vertical,
        yearGridItems: [GridItem] = [.init()]
    ) {
        self.init(
            startDate: startDate,
            yearLimit: yearLimit,
            calendar: calendar,
            scrollTrigger: scrollTrigger,
            includeBlanks: includeBlanks,
            lazyYears: lazyYears,
            lazyMonths: lazyMonths,
            dayScrollEnabled: dayScrollEnabled,
            dayScrollAxis: dayScrollAxis,
            dayGridItems: dayGridItems,
            monthScrollEnabled: monthScrollEnabled,
            monthScrollAxis: monthScrollAxis,
            monthGridItems: monthGridItems,
            yearScrollEnabled: yearScrollEnabled,
            yearScrollAxis: yearScrollAxis,
            yearGridItems: yearGridItems
        ) { baseView, model in
            baseView
        } monthContent: { baseView, daysView, model in
            baseView
        } yearContent: { baseView, monthsView, model in
            baseView
        }
    }
}

#Preview("Default") {
    OBBaseCalendar(
        calendar: .current,
        scrollTrigger: .constant("")
    )
    .dayModifier { baseView, model in
        baseView
            .foregroundColor(.white)
            .background(Color.blue)
    }
}

#Preview("Horizontal") {
    GeometryReader { geometry in
        OBBaseCalendar(
            calendar: .current,
            scrollTrigger: .constant(""),
            includeBlanks: false,
            monthScrollAxis: .horizontal,
            yearScrollAxis: .horizontal
        )
        .dayModifier { baseView, model in
            baseView
                .foregroundColor(.white)
                .background(Color.blue)
        }
        .monthModifier { baseView, daysView, model in
            HStack(spacing: .zero) {
                baseView
                    .padding()
                Divider()
            }
            .frame(width: geometry.size.width)
        }
    }
}

#Preview("Day Modifier") {
    OBBaseCalendar(
        calendar: .current,
        scrollTrigger: .constant(""),
        includeBlanks: false
    )
    .dayModifier { baseView, model in
        baseView
            .background(Color.blue)
            .padding(2)
            .foregroundColor(.white)
    }
}

#Preview("Month Modifier") {
    OBBaseCalendar(
        calendar: .current,
        scrollTrigger: .constant("")
    )
    .monthModifier{ baseView, daysView, model in
        VStack {
            Text("Modified Months")
            daysView
        }
        .padding()
    }
}

#Preview("Modified Day + Modified Month") {
    OBBaseCalendar(
        calendar: .current,
        scrollTrigger: .constant("")
    )
    .dayModifier { baseView, model in
        baseView
            .foregroundColor(Color(.red))
    }
    .monthModifier { baseView, daysView, model in
        VStack {
            Text("Modified Months")
            daysView
        }
        .padding()
    }
}
