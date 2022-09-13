import React from "react";

// import woman image
import WomanImg from "../assets/img/banner-woman2.webp";
import World3 from "../assets/img/world33.svg";

const Hero = () => {
  return (
    <section
      id="home"
      className="lg:h-[85vh] flex items-center  bg-primary lg:bg-cover lg:bg-center lg:bg-no-repeat py-32 lg:py-0 overflow-hidden"
    >
      <div className="container mx-auto h-full">
        <div className="flex items-center h-full pt-8">
          <div className="flex-1 flex flex-col items-center lg:items-start">
            <h1 className="text-4xl leading-[44px] md:text-5xl md:leading-tight lg:text-7xl lg:leading-[1.2] font-bold md:tracking-[-2px]">
              World3 🌍
            </h1>
            <p className="pt-4 pb-8 md:pt-6 md:pb-12 max-w-[480px] text-lg text-center lg:text-left">
              Targeting to solve SDG goals by funding paniors or researches who
              are making the world a better in cyrpto
            </p>
            <button className="btn btn-md bg-green-600 hover:bg-secondary-hover md:btn-lg transition-all">
              Donate to a researcher
            </button>
          </div>
          <div className="hidden lg:flex flex-1 w-32  justify-end items-end ">
            <img src={World3} alt="" width={400} height={400} />
          </div>
        </div>
      </div>
    </section>
  );
};

export default Hero;
